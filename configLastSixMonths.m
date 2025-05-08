% configLastSixMonths

dateNow = datetime;
dateEnd = dateshift( dateNow, 'end', 'day' );
dateBeg = dateEnd - calmonths(6);

plotShape = 'l';
plotSpacing = 'compact';
plotSize = 1200;

filePlot = 'fig--megaplot3--lastSixMonths.png';
