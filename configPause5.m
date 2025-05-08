% configPause5

dateBeg = datetime( dateCommon( 'begPause5+2' ), 'ConvertFrom','datenum');
dateNow = datetime;
dateEnd = dateshift( dateNow, 'end', 'day' );

plotShape = 'l';
plotSize = 1200;

filePlot = 'fig--megaplot3--pause5.png';
