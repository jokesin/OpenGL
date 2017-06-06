package GL_Display is

   procedure Init;
   procedure Open_Window(Width,Height : Natural; Depth_Bits : Natural := 0);
   procedure Swap_Buffers;
   procedure Poll_Events;
   procedure Set_Window_Title(Value : String);
   function Escape_Pressed return Boolean;
   function Window_Opened return Boolean;
   procedure Close_Window;
   procedure Shutdown;
   procedure Configure_Minimum_OpenGL_Version(Major,Minor : Natural);
   procedure Get_OpenGL_Version(Major,Minor:out Natural);

end GL_Display;
