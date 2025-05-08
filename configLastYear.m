% configLastYear

dateNow = datetime;
dateEnd = dateshift( dateNow, 'end', 'day' );
dateBeg = dateEnd - calmonths(12);

plotShape = 'l';
plotSpacing = 'compact';
plotSize = 1200;

filePlot = 'fig--megaplot3--lastYear.png';
