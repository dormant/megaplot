% configLastFiveYears

dateNow = datetime;
dateEnd = dateshift( dateNow, 'end', 'day' );
dateBeg = dateEnd - calyears(5);

plotShape = 'l';
plotSize = 1200;

filePlot = 'fig--megaplot3--lastFiveYears.png';
