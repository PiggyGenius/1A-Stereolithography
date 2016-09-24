with Ada.Command_Line; use Ada.Command_Line;
with STL; use STL;
with Parser_Svg; use Parser_Svg;
with Ada.Text_IO; use Ada.Text_IO;
with Math; use Math;

with Liste_Generique;
with Ada.Float_Text_IO;use Ada.Float_Text_IO;

procedure Main is
   Segments : Liste_Points.Liste;
   Facettes : Liste_Facettes.Liste;
   PROCEDURE Traiter(E:IN OUT Point2D) IS
   BEGIN
      Put("L ");Put(E(1),exp=>0,aft=>0);Put(",");Put(E(2),exp=>0,aft=>0);Put(" ");
   END;
   PROCEDURE Run IS NEW Liste_Points.Parcourir(Traiter);
begin

   if Argument_Count /= 2 then
      Put_Line(Standard_Error,
               "usage : " & Command_Name &
               " fichier_entree.svg fichier_sortie.stl");
      Set_Exit_Status(Failure);
      return;
   end if;

   --on charge la courbe de bezier et la convertit en segments
   Header(Argument(2));
   Chargement_Bezier(Argument(1),Argument(2), Segments);
   --Run(Segments);
   --on convertit en facettes par rotation
   Creation(Segments, Facettes);
   --on sauvegarde le modele obtenu
   Sauvegarder(Argument(2), Facettes);
   Footer(Argument(2));
end;
