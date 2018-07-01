
// *********************************************
// ******* START mesh control parameters *******


// scaling ratio between plane 1 and plane 2
ratio_1 = 1.96;
ratio_2 = 6.4;

// orifice radius
R_o = 0.5;

// orifice inlet radius conversion
Orir_p1 = R_o / Sqrt(2);

// computational domain length
// constant length scale region
l = 8*2*R_o;

// increasing length scale region
s = 37*2*R_o;

// plane 1 square width
w_p1 = Orir_p1*0.6;

// plane 1 circle radius
r_p1 = Orir_p1;



// plane 2 circle radius
r_p2 = r_p1*ratio_1;

// plane 2 square width
w_p2 = r_p2*0.6;



// plane 3 circle radius
r_p3 = r_p1*ratio_2;

// plane 3 square width
w_p3 = r_p3*0.6;


// square curvature radius
sq_r_p1 = Orir_p1;
sq_r_p2 = r_p2;
sq_r_p3 = r_p3;

// outer circles
r_out1 = 5*Orir_p1;
r_out2 = r_out1*ratio_1;
r_out3 = r_out1*ratio_2;


//  ——— cell sizes ———
//
// center square (cell size: 0.012)
n_sq = Floor(2*w_p1/0.012/2)+1;

// first section axial direction (cell size: 0.012) 
n_ax1 = Floor(l/0.012/4)+1;

// second section axial direction (cell size: 0.012) 
n_ax2 = Floor(s/0.012/4)+1;

// radial direction IN ORIFICE (cell size: 0.012) 
n_r1 = Floor(0.25/0.012/4)+1;

// radial direction OUTSIDE ORIFICE (cell size: 0.012) 
n_r2 = Floor(0.25/0.012/4)+1;

// ******* END mesh control parameters *******
// *******************************************

// —— centerpoint of plane 1 ——
Point(1) = {0, 0, 0, 0};


// center point for square radius
Point(23) = {-sq_r_p1, 0, 0, 0};
Point(24) = {0, sq_r_p1, 0, 0};
Point(25) = {sq_r_p1, 0, 0, 0};
Point(26) = {0, -sq_r_p1, 0, 0};

Point(27) = {-sq_r_p2, 0, l, 0};
Point(28) = {0, sq_r_p2, l, 0};
Point(29) = {sq_r_p2, 0, l, 0};
Point(30) = {0, -sq_r_p2, l, 0};

// square points plane 1
Point(2) = {w_p1, w_p1, 0, 1.0};
Point(3) = {w_p1, -w_p1, 0, 1.0};
Point(4) = {-w_p1, -w_p1, 0, 1.0};
Point(5) = {-w_p1, w_p1, 0, 1.0};

// square lines plane 1
Circle(1) = {2,23,3};
Circle(2) = {3,24,4};
Circle(3) = {4,25,5};
Circle(4) = {5,26,2};

// circle point plane 1
Point(6) = {r_p1, r_p1, 0, 1.0};
Point(7) = {r_p1, -r_p1, 0, 1.0};
Point(8) = {-r_p1, -r_p1, 0, 1.0};
Point(9) = {-r_p1, r_p1, 0, 1.0};

// circle arcs plane 1
Circle(5) = {6, 1, 7};
Circle(6) = {7, 1, 8};
Circle(7) = {8, 1, 9};
Circle(8) = {9, 1, 6};


// —— centerpoint of plane 2 ——
Point(10) = {0, 0, l, 0};

// square points plane 2
Point(11) = {w_p2, w_p2, l, 1.0};
Point(12) = {w_p2, -w_p2, l, 1.0};
Point(13) = {-w_p2, -w_p2, l, 1.0};
Point(14) = {-w_p2, w_p2, l, 1.0};

// square lines plane 2
Circle(9) = {11,27,12};
Circle(10) = {12,28,13};
Circle(11) = {13,29,14};
Circle(12) = {14,30,11};

// circle point plane 2
Point(15) = {r_p2, r_p2, l, 1.0};
Point(16) = {r_p2, -r_p2, l, 1.0};
Point(17) = {-r_p2, -r_p2, l, 1.0};
Point(18) = {-r_p2, r_p2, l, 1.0};

// circle arcs plane 2
Circle(13) = {15, 10, 16};
Circle(14) = {16, 10, 17};
Circle(15) = {17, 10, 18};
Circle(16) = {18, 10, 15};

// lines between square and circle in plane 1
Line(17) = {2,6};
Line(18) = {3,7};
Line(19) = {4,8};
Line(20) = {5,9};

// lines between square and circle in plane 2
Line(21) = {11,15};
Line(22) = {12,16};
Line(23) = {13,17};
Line(24) = {14,18};

// lines between square in plane 1 and square in plane 2
Line(25) = {2,11};
Line(26) = {3,12};
Line(27) = {4,13};
Line(28) = {5,14};

// lines between circle in plane 1 and circle in plane 2
Line(29) = {6,15};
Line(30) = {7,16};
Line(31) = {8,17};
Line(32) = {9,18};

// square surface plane 1
Line Loop(1) = {1, 2, 3, 4};
Plane Surface(1) = {1};

// square surface plane 2
Line Loop(2) = {9, 10, 11, 12};
Plane Surface(2) = {2};


// square volume
Line Loop(3) = {1, 26, -9, -25};
Surface(3) = {3};
Line Loop(4) = {3, 28, -11, -27};
Surface(4) = {4};
Line Loop(5) = {4, 25, -12, -28};
Surface(5) = {5};
Line Loop(6) = {2, 27, -10, -26};
Surface(6) = {6};
Surface Loop(1) = {1, 3, 6, 4, 5, 2};
Volume(1) = {1};

// the four arc volumes
Line Loop(7) = {24, -32, -20, 28};
Plane Surface(7) = {7};
Line Loop(8) = {25, 21, -29, -17};
Plane Surface(8) = {8};
Line Loop(13) = {13, -30, -5, 29};
Surface(17) = {13};
Line Loop(14) = {22, -30, -18, 26};
Plane Surface(18) = {14};
Line Loop(15) = {18, -5, -17, 1};
Plane Surface(19) = {15};
Line Loop(16) = {22, -13, -21, 9};
Plane Surface(20) = {16};
Surface Loop(3) = {20, 18, 17, 19, 3, 8};
Volume(3) = {3};

Line Loop(17) = {30, 14, -31, -6};
Surface(21) = {17};
Line Loop(18) = {22, 14, -23, -10};
Plane Surface(22) = {18};
Line Loop(19) = {19, -6, -18, 2};
Plane Surface(23) = {19};
Line Loop(20) = {23, -31, -19, 27};
Plane Surface(24) = {20};
Surface Loop(4) = {22, 21, 24, 23, 18, 6};
Volume(4) = {4};

Line Loop(21) = {11, 24, -15, -23};
Plane Surface(25) = {21};
Line Loop(22) = {3, 20, -7, -19};
Plane Surface(26) = {22};
Line Loop(23) = {32, -15, -31, 7};
Surface(27) = {23};
Surface Loop(5) = {27, 25, 26, 24, 7, 4};
Volume(5) = {5};

Line Loop(24) = {12, 21, -16, -24};
Plane Surface(28) = {24};
Line Loop(25) = {4, 17, -8, -20};
Plane Surface(29) = {25};
Line Loop(26) = {29, -16, -32, 8};
Surface(30) = {26};
Surface Loop(6) = {28, 30, 29, 5, 7, 8};
Volume(6) = {6};



// create orifice surface
/*
Point(19) = {Orir_p1, Orir_p1, 0, 1.0};
Point(20) = {Orir_p1, -Orir_p1, 0, 1.0};
Point(21) = {-Orir_p1, -Orir_p1, 0, 1.0};
Point(22) = {-Orir_p1, Orir_p1, 0, 1.0};
Circle(33) = {19, 1, 20};
Circle(34) = {20, 1, 21};
Circle(35) = {21, 1, 22};
Circle(36) = {22, 1, 19};
Line Loop(27) = {36, 33, 34, 35};
Plane Surface(31) = {27};
*/
// surface between circle and square
//Plane Surface(32) = {1, 27};

// outer circle points plane 1
Point(230) = {r_out1, r_out1, 0, 1.0};
Point(240) = {r_out1, -r_out1, 0, 1.0};
Point(250) = {-r_out1, -r_out1, 0, 1.0};
Point(260) = {-r_out1, r_out1, 0, 1.0};

// outer circle arcs plane 1
Circle(33) = {230, 1, 240};
Circle(34) = {240, 1, 250};
Circle(35) = {250, 1, 260};
Circle(36) = {260, 1, 230};

// outer circle surfaces plane 1
Line(37) = {6, 230};
Line(38) = {9, 260};
Line(39) = {8, 250};
Line(40) = {7, 240};
Line Loop(27) = {37, -36, -38, 8};
Plane Surface(31) = {27};
Line Loop(28) = {7, 38, -35, -39};
Plane Surface(32) = {28};
Line Loop(29) = {39, -34, -40, 6};
Plane Surface(33) = {29};
Line Loop(30) = {40, -33, -37, 5};
Plane Surface(34) = {30};

// outer circle points plane 2
Point(231) = {r_out2, r_out2, l, 1.0};
Point(242) = {r_out2, -r_out2, l, 1.0};
Point(253) = {-r_out2, -r_out2, l, 1.0};
Point(264) = {-r_out2, r_out2, l, 1.0};

// outer circle arcs plane 2
Circle(41) = {231, 10, 242};
Circle(42) = {242, 10, 253};
Circle(43) = {253, 10, 264};
Circle(44) = {264, 10, 231};

// connecting outer circles
Line(45) = {230, 231};
Line(46) = {260, 264};
Line(47) = {250, 253};
Line(48) = {240, 242};

// connecting inner and outer circle plane 2
Line(49) = {18, 264};
Line(50) = {15, 231};
Line(51) = {16, 242};
Line(52) = {17, 253};

// outer circle surfaces plane 2
Line Loop(31) = {16, 50, -44, -49};
Plane Surface(35) = {31};
Line Loop(32) = {13, 51, -41, -50};
Plane Surface(36) = {32};
Line Loop(33) = {51, 42, -52, -14};
Plane Surface(37) = {33};
Line Loop(34) = {43, -49, -15, 52};
Plane Surface(38) = {34};

// creating surfaces for outer circle volumes
//+
Line Loop(35) = {37, 45, -50, -29};
//+
Plane Surface(39) = {35};
//+
Line Loop(36) = {32, 49, -46, -38};
//+
Plane Surface(40) = {36};
//+
Line Loop(37) = {39, 47, -52, -31};
//+
Plane Surface(41) = {37};
//+
Line Loop(38) = {51, -48, -40, 30};
//+
Plane Surface(42) = {38};
//+
Line Loop(39) = {45, 41, -48, -33};
//+
Surface(43) = {39};
//+
Line Loop(40) = {44, -45, -36, 46};
//+
Surface(44) = {40};
//+
Line Loop(41) = {46, -43, -47, 35};
//+
Surface(45) = {41};
//+
Line Loop(42) = {34, 47, -42, -48};
//+
Surface(46) = {42};

// creating outer volumes

//+
Surface Loop(7) = {30, 39, 40, 44, 35, 31};
//+
Volume(7) = {7};
//+
Surface Loop(8) = {27, 40, 41, 45, 38, 32};
//+
Volume(8) = {8};
//+
Surface Loop(9) = {21, 37, 46, 33, 41, 42};
//+
Volume(9) = {9};
//+
Surface Loop(10) = {17, 42, 39, 43, 36, 34};
//+
Volume(10) = {10};



// self-similar region
// —— centerpoint of plane 3 ——
Point(100) = {0, 0, l+s, 0};

// square points plane 3
Point(110) = {w_p3, w_p3, l+s, 1.0};
Point(120) = {w_p3, -w_p3, l+s, 1.0};
Point(130) = {-w_p3, -w_p3, l+s, 1.0};
Point(140) = {-w_p3, w_p3, l+s, 1.0};

// circle point plane 3
Point(150) = {r_p3, r_p3, l+s, 1.0};
Point(160) = {r_p3, -r_p3, l+s, 1.0};
Point(170) = {-r_p3, -r_p3, l+s, 1.0};
Point(180) = {-r_p3, r_p3, l+s, 1.0};

// outer circle points plane 3
Point(331) = {r_out3, r_out3, l+s, 1.0};
Point(342) = {r_out3, -r_out3, l+s, 1.0};
Point(353) = {-r_out3, -r_out3, l+s, 1.0};
Point(364) = {-r_out3, r_out3, l+s, 1.0};

// centerpoint for square radius plane 3
Point(270) = {-sq_r_p3, 0, l+s, 0};
Point(280) = {0, sq_r_p3, l+s, 0};
Point(290) = {sq_r_p3, 0, l+s, 0};
Point(300) = {0, -sq_r_p3, l+s, 0};

// square lines plane 3
Circle(90) = {110,270,120};
Circle(100) = {120,280,130};
Circle(110) = {130,290,140};
Circle(120) = {140,300,110};

// circle arcs plane 3
Circle(130) = {150, 100, 160};
Circle(140) = {160, 100, 170};
Circle(150) = {170, 100, 180};
Circle(160) = {180, 100, 150};

// outer circle arcs plane 3
Circle(410) = {331, 100, 342};
Circle(420) = {342, 100, 353};
Circle(430) = {353, 100, 364};
Circle(440) = {364, 100, 331};

// lines between square and circle in plane 3
Line(421) = {110,150};
Line(422) = {120,160};
Line(423) = {130,170};
Line(424) = {140,180};

// connecting inner and outer circle plane 3
Line(490) = {180, 364};
Line(500) = {150, 331};
Line(510) = {160, 342};
Line(520) = {170, 353};

// lines between square in plane 2 and square in plane 3
Line(525) = {11,110};
Line(526) = {12,120};
Line(527) = {13,130};
Line(528) = {14,140};

// lines between circle in plane 2 and circle in plane 3
Line(529) = {15,150};
Line(530) = {16,160};
Line(531) = {17,170};
Line(532) = {18,180};

// connecting outer circles plane 2 and plane 3
Line(450) = {231,331};
Line(460) = {264,364};
Line(470) = {253,353};
Line(480) = {242,342};


// surfaces and volumes between plane 2 and plane 3
//+
Line Loop(43) = {16, 529, -160, -532};
//+
Surface(47) = {43};
//+
Line Loop(44) = {532, -150, -531, 15};
//+
Surface(48) = {44};
//+
Line Loop(45) = {531, -140, -530, 14};
//+
Surface(49) = {45};
//+
Line Loop(46) = {530, -130, -529, 13};
//+
Surface(50) = {46};
//+
Line Loop(47) = {450, -440, -460, 44};
//+
Surface(51) = {47};
//+
Line Loop(48) = {430, -460, -43, 470};
//+
Surface(52) = {48};
//+
Line Loop(49) = {470, -420, -480, 42};
//+
Surface(53) = {49};
//+
Line Loop(50) = {480, -410, -450, 41};
//+
Surface(54) = {50};
//+
Line Loop(51) = {12, 525, -120, -528};
//+
Surface(55) = {51};
//+
Line Loop(52) = {528, -110, -527, 11};
//+
Surface(56) = {52};
//+
Line Loop(53) = {10, 527, -100, -526};
//+
Surface(57) = {53};
//+
Line Loop(54) = {526, -90, -525, 9};
//+
Surface(58) = {54};
//+
Line Loop(55) = {500, -440, -490, 160};
//+
Plane Surface(59) = {55};
//+
Line Loop(56) = {500, 410, -510, -130};
//+
Plane Surface(60) = {56};
//+
Line Loop(57) = {510, 420, -520, -140};
//+
Plane Surface(61) = {57};
//+
Line Loop(58) = {140, -423, -100, 422};
//+
Plane Surface(62) = {58};
//+
Line Loop(59) = {130, -422, -90, 421};
//+
Plane Surface(63) = {59};
//+
Line Loop(60) = {421, -160, -424, 120};
//+
Plane Surface(64) = {60};
//+
Line Loop(61) = {424, -150, -423, 110};
//+
Plane Surface(65) = {61};
//+
Line Loop(62) = {120, 90, 100, 110};
//+
Plane Surface(66) = {62};
//+
Line Loop(63) = {529, 500, -450, -50};
//+
Plane Surface(67) = {63};
//+
Line Loop(64) = {530, 510, -480, -51};
//+
Plane Surface(68) = {64};
//+
Line Loop(65) = {520, -470, -52, 531};
//+
Plane Surface(69) = {65};
//+
Line Loop(66) = {532, 490, -460, -49};
//+
Plane Surface(70) = {66};
//+
Line Loop(67) = {520, 430, -490, -150};
//+
Plane Surface(71) = {67};
//+

//+
Surface Loop(11) = {2, 56, 55, 58, 57, 66};
//+
Volume(11) = {11};
//+
Line Loop(68) = {527, 423, -531, -23};
//+
Plane Surface(72) = {68};
//+
Line Loop(69) = {526, 422, -530, -22};
//+
Plane Surface(73) = {69};
//+
Line Loop(70) = {421, -529, -21, 525};
//+
Plane Surface(74) = {70};
//+
Line Loop(71) = {532, -424, -528, 24};
//+
Plane Surface(75) = {71};
//+
Surface Loop(12) = {22, 57, 73, 49, 62, 72};
//+
Volume(12) = {12};
//+
Surface Loop(13) = {25, 56, 65, 48, 75, 72};
//+
Volume(13) = {13};
//+
Surface Loop(14) = {28, 64, 74, 75, 55, 47};
//+
Volume(14) = {14};
//+
Surface Loop(15) = {50, 58, 20, 63, 74, 73};
//+
Volume(15) = {15};
//+
Surface Loop(16) = {49, 37, 68, 53, 61, 69};
//+
Volume(16) = {16};
//+
Surface Loop(17) = {38, 52, 71, 69, 70, 48};
//+
Volume(17) = {17};
//+
Surface Loop(18) = {51, 59, 35, 47, 70, 67};
//+
Volume(18) = {18};
//+
Surface Loop(19) = {54, 60, 36, 68, 67, 50};
//+
Volume(19) = {19};


// transfinite arcs 
Transfinite Line {1, 2, 3, 4, 5, 6, 7, 8, 33, 34, 35, 36, 9, 10, 11, 12, 13, 14, 15, 16, 41, 42, 43, 44, 90, 100, 110, 120, 130, 140, 150, 160, 410, 420, 430, 440} = 6;
//n_se

// transfinite radial lines 
// in orifice
Transfinite Line {17, 18, 19, 20, 21, 22, 23, 24, 421, 422, 423, 424} = 3;
//n_r1

// outside orifice
Transfinite Line {37, 38, 39, 40, 49, 50, 51, 52, 490, 500, 510, 520} = 21 Using Progression 1.0;
//

// transfinite axial lines
// section 1
Transfinite Line {25, 26, 27, 28, 29, 30, 31, 32, 45, 46, 47, 48} = 81;
//n_ax1

// section 2
Transfinite Line {525, 526, 527, 528, 529, 530, 531, 532, 450, 460, 470, 480} = 278  Using Progression 1.002;
// n_ax2

// use the transfinite algorithm on all planes and volumes
Transfinite Surface "*";
Recombine Surface "*";
Transfinite Volume "*";


// physical surfaces and volume
Physical Surface("orifice") = {19, 23, 26, 29, 1};
Physical Surface("inflow_boundary") = {34, 33, 32, 31};
Physical Surface("outflow_boundary") = {59, 60, 61, 71, 62, 63, 64, 65,66};
Physical Surface("lateral_boundary") = {43,44,45,46, 51, 52, 53, 54};
Physical Volume("internalField") = {6, 3, 1, 4, 5, 7, 8, 9, 10, 16, 17, 18, 19, 11, 12, 13, 14, 15};


