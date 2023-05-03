function [indS_BL, indS_HG, indC_Bl, indC_HG] = nombr2_S(N)


 vector_n2= contains(N,"baseline_preproespinoza");
 vector_n3= contains(N,"baseline_preprofernanda");
 vector_n5= contains(N,"baseline_preproloyola");
 vector_n6= contains(N,"baseline_preprotrinidad");
 vector_n7= contains(N,"baseline_preprovalentinacaneo");
 vector_n8= contains(N,"baseline_preprovanya");

 indS_BL= vector_n2+ vector_n3+ vector_n5+ vector_n6+ vector_n7+ vector_n8;

 vector_n2= contains(N,"Cespinoza");
 vector_n3= contains(N,"Cfernanda");
 vector_n5= contains(N,"Cloyola");
 vector_n6= contains(N,"Ctrinidad");
 vector_n7= contains(N,"Cvalentinacaneo");
 vector_n8= contains(N,"Cvanya");

 indS_HG= vector_n2+ vector_n3+ vector_n5+ vector_n6+ vector_n7+ vector_n8;

 vector_n1= contains(N,"baseline_preproalejandra");
 vector_n2= contains(N,"baseline_preprobastian");
 vector_n3= contains(N,"baseline_preprocamilo");
 vector_n4= contains(N,"baseline_preprodaniel");
 vector_n5= contains(N,"baseline_preprofrancisca");
 vector_n6= contains(N,"baseline_preprogisela");
 vector_n7= contains(N,"baseline_preprojosefina");
 vector_n8= contains(N,"baseline_preprojulianna");
 vector_n9= contains(N,"baseline_preprovalentina");

 indC_Bl= vector_n1+ vector_n2+ vector_n3+ vector_n4+ vector_n5+ vector_n6+...
      vector_n7+ vector_n8+ vector_n9;

 vector_n1= contains(N,"Calejandra");
 vector_n2= contains(N,"Cbastian");
 vector_n3= contains(N,"Ccamilo");
 vector_n4= contains(N,"Cdaniel");
 vector_n5= contains(N,"Cfrancisca");
 vector_n6= contains(N,"Cgisela");
 vector_n7= contains(N,"Cjosefina");
 vector_n8= contains(N,"Cjulianna");
 vector_n9= contains(N,"Cvalentinah");

 indC_HG= vector_n1+ vector_n2+ vector_n3+ vector_n4+ vector_n5+ vector_n6+...
      vector_n7+ vector_n8+ vector_n9;

return