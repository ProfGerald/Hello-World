/* Reference: Delwiche and Slaughter, The Little SAS Book, 5th Edition, p. 124. */

/* Section 4.13 */

options linesize=70 nodate pageno=1 formchar = '|----|+|---+=|-/<>*';
DATA boats;
   INFILE 'C:\Users\gcleg\Documents\boats.txt';
   INPUT Name $ 1-12 Port $ 14-20 Locomotion $ 22-26 Type $ 28-30 
      Price 32-37 Length 39-41;
RUN;

* Tabulations with three dimensions;
PROC TABULATE DATA = boats;
   CLASS Port Locomotion Type;
   TABLE Port, Locomotion, Type;
   TITLE 'Number of Boats by Port, Locomotion, and Type';
RUN;


/* Section 4.14 */

* Tabulations with two dimensions and statistics;
PROC TABULATE DATA = boats;
   CLASS Locomotion Type;
   VAR Price;
   TABLE Locomotion ALL, MEAN*Price*(Type ALL);
   TITLE 'Mean Price by Locomotion and Type';
RUN;

/* Section 4.15 */

* PROC TABULATE report with options;
PROC TABULATE DATA = boats FORMAT=DOLLAR9.2;
   CLASS Locomotion Type;
   VAR Price;
   TABLE Locomotion ALL, MEAN*Price*(Type ALL)
      /BOX='Full Day Excursions' MISSTEXT='none';
   TITLE;
RUN;

/* Section 4.16 */

* Changing headers;
PROC FORMAT;
   VALUE $typ  'cat' = 'catamaran'
               'sch' = 'schooner'
               'yac' = 'yacht';
RUN;
PROC TABULATE DATA = boats FORMAT=DOLLAR9.2;
   CLASS Locomotion Type;
   VAR Price;
   FORMAT Type $typ.;
   TABLE Locomotion='' ALL, 
      MEAN=''*Price='Mean Price by Type of Boat'*(Type='' ALL)
      /BOX='Full Day Excursions' MISSTEXT='none';
   TITLE;
RUN;

* Using the FORMAT= option in the TABLE statement;
PROC TABULATE DATA = boats;
   CLASS Locomotion Type;
   VAR Price Length;
   TABLE Locomotion ALL, 
      MEAN * (Price*FORMAT=DOLLAR7.2 Length*FORMAT=2.0) * (Type ALL);
   TITLE 'Price and Length by Type of Boat';
RUN;
QUIT;
