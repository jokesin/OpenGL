with Ada.Text_IO;

with Glfw;
with Glfw.Windows;

with GL_Display;

procedure Main is
begin
   GL_Display.Init;
   GL_Display.Configure_Minimum_OpenGL_Version(4,0);
   GL_Display.Open_Window(Width => 500, Height => 500);

   declare
      Major,Minor : Natural;
   begin
      GL_Display.Get_OpenGL_Version(Major,Minor);
      Ada.Text_IO.Put_Line("OpenGL version : " & Major'img & "." & Minor'Img);
   end;

   while not GL_Display.Escape_Pressed and
     GL_Display.Window_Opened loop

      GL_Display.Swap_Buffers;
      GL_Display.Poll_Events;
   end loop;

   GL_Display.Shutdown;

end Main;
