with Ada.Text_IO;

with Glfw.Windows.Context;
with Glfw.Windows.Hints;
with Glfw.Input.Keys;
with Glfw.Errors;

package body GL_Display is

   type GL_Window is new Glfw.Windows.Window with null record;

   overriding
   procedure Close_Requested(Object : not null access GL_Window) is
   begin
      Object.Destroy;
   end Close_Requested;

   Main_GL_Window : constant not null access GL_Window := new GL_Window;

   procedure Print_Error(Code : Glfw.Errors.Kind; Description : String) is
   begin
      Ada.Text_IO.Put_Line("Error occured (" & Code'Img & "): " & Description);
   end Print_Error;

   procedure Enable_Print_Errors is
   begin
      Glfw.Errors.Set_Callback(Print_Error'Access);
   end Enable_Print_Errors;


   -- Init --

   procedure Init is
   begin
      Enable_Print_Errors;
      Glfw.Init;
   end Init;


   -- Open_Window --

   procedure Open_Window (Width,Height : Natural; Depth_Bits : Natural := 0) is
   begin
      if not Main_GL_Window.Initialized then
         Glfw.Windows.Hints.Set_Depth_Bits(Depth_Bits);
         Main_GL_Window.Init(Glfw.Size(Width),Glfw.Size(Height),"Main OpenGL Window");
      end if;
      Main_GL_Window.Show;
      Main_GL_Window.Enable_Callback(Glfw.Windows.Callbacks.Close);
      Glfw.Windows.Context.Make_Current(Main_GL_Window);
   end Open_Window;


   -- Swap_Buffers --

   procedure Swap_Buffers is
   begin
      Glfw.Windows.Context.Swap_Buffers(Main_GL_Window);
   end Swap_Buffers;


   -- Poll_Events --

   procedure Poll_Events is
   begin
      Glfw.Input.Poll_Events;
   end Poll_Events;


   -- Set_Window_Title --

   procedure Set_Window_Title (Value : String) is
   begin
      Main_GL_Window.Set_Title(Value);
   end Set_Window_Title;


   -- Escape_Pressed --

   function Escape_Pressed return Boolean
   is
      use type Glfw.Input.Button_State;
   begin
      return Main_GL_Window.Initialized and then
        Main_GL_Window.Key_State(Glfw.Input.Keys.Escape) = Glfw.Input.Pressed;
   end Escape_Pressed;


   -- Window_Opened --

   function Window_Opened return Boolean is
   begin
      return Main_GL_Window.Initialized and then Main_GL_Window.Visible;
   end Window_Opened;


   -- Close_Window --

   procedure Close_Window is
   begin
      Main_GL_Window.Destroy;
   end Close_Window;


   -- Shutdown --

   procedure Shutdown renames Glfw.Shutdown;


   -- Configure_Minimum_OpenGL_Version --

   procedure Configure_Minimum_OpenGL_Version (Major,Minor : Natural) is
   begin
      Glfw.Windows.Hints.Set_Minimum_OpenGL_Version(Major, Minor);
      -- needed for OSX (from example)
      if Major >= 3 then
         Glfw.Windows.Hints.Set_Forward_Compat(True);
         Glfw.Windows.Hints.Set_Profile(Glfw.Windows.Context.Core_Profile);
      end if;
   end Configure_Minimum_OpenGL_Version;

   -- Get_OpenGL_Version --

   procedure Get_OpenGL_Version(Major,Minor:out Natural)
   is
      Revision : Natural;
   begin
      if Main_GL_Window.Initialized then
         Main_GL_Window.Get_OpenGL_Version(Major,Minor,Revision);
      end if;
   end Get_OpenGL_Version;

end GL_Display;
