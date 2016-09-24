PACKAGE BODY Math IS

   FUNCTION "+" (A: Vecteur;B: Vecteur) RETURN Vecteur IS
      R: Vecteur(A'Range);
   BEGIN
      R(1):=A(1)+B(1);
      R(2):=A(2)+B(2);
      RETURN R;
   END;

   FUNCTION "*" (Facteur: Float;V: Vecteur) RETURN Vecteur IS
      R: Vecteur(V'Range);
   BEGIN
      R(1):=V(1)*Facteur;
      R(2):=V(2)*Facteur;
      RETURN R;
   END;

   PROCEDURE Bezier(P1,C1,C2,P2: Point2D;Nb_Points: Positive;Points:OUT Liste) IS
      P: Point2D;
      step: Float := 0.0;
   BEGIN
      Insertion_Queue(Points,P1);
      FOR i IN 1..nb_Points LOOP
         step:=(Float(i)/Float(nb_Points));
         P:=(((1.0-step)**3)*P1)+(3.0*step*((1.0-step)**2)*C1)+(3.0*(step**2)*(1.0-step)*C2)+((step**3)*P2);
         Insertion_Queue(Points,P);
      END LOOP;
   END;

   PROCEDURE Bezier(P1,C,P2: Point2D;nb_Points: Positive;Points:OUT Liste) IS
      P: Point2D;
      step: Float := 0.0;
   BEGIN
      Insertion_Queue(Points,P1);
      FOR i IN 1..nb_Points LOOP
         step:=(Float(i)/Float(nb_Points));
         P:=(((1.0-step)**2)*P1)+(2.0*step*(1.0-step)*C)+(step**2)*P2;
         Insertion_Queue(Points,P);
      END LOOP;   
   END;
END;
