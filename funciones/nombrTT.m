function ind= nombrTT(N,j)
if j==1
 vector_n1= contains(N,"carolina");
 %vector_n2= contains(N,"espinoza");
 vector_n3= contains(N,"fernanda");
 vector_n4= contains(N,"ibarra");
 vector_n5= contains(N,"loyola");
 vector_n6= contains(N,"rayen");
 vector_n7= contains(N,"caneo");
 vector_n8= contains(N,"vanya");
 vector_n9= contains(N,"trinidad");
 ind= vector_n1+ vector_n3+ vector_n4+ vector_n5+ vector_n6+ vector_n7+ vector_n8+vector_n9;
else 
 vector_n1= contains(N,"alejandra");
 vector_n2= contains(N,"bastian");
 vector_n3= contains(N,"camilo");
 vector_n4= contains(N,"daniel");
 %vector_n5= nan;%contains(N,"diego");
 vector_n6= contains(N,"francisca");
 vector_n7= contains(N,"gisela");
 vector_n8= contains(N,"josefina");
 vector_n9= contains(N,"julianna");
 vector_n10= contains(N,"mariat");
 %vector_n11= nan;%contains(N,"sergio");
 vector_n12= contains(N,"valentina");
vector_n12_n= ~contains(N,"caneo");
 vector_n12=vector_n12.*vector_n12_n;
 vector_n13= contains(N,"vial");
 
ind= vector_n1+ vector_n2+ vector_n3+ vector_n4+ vector_n6+...
    vector_n7+ vector_n8+vector_n9+vector_n10+vector_n12+vector_n13;

end
return