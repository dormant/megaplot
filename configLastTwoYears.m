% configLastTwoYears

dateNow = datetime;
dateEnd = dateshift( dateNow, 'end', 'day' );
dateBeg = dateEnd - calyears(2);

plotShape = 'l';
plotSpacing = 'compact';
plotSize = 1200;

filePlot = 'fig--megaplot3--lastTwoYears.png';
