% configDefaultsNothing

dateBeg = datetime( 1995, 1, 1 );
dateNow = datetime;
dateEnd = dateshift( dateNow, 'end', 'day' );

plotShape = 's';
plotSize = 0;
plotSpacing = 'none';
plotBackground = 'a';
plotSubPhases = 'n';
plotFlow = 'v';

plotSeis = 'n';
plotSeisTypes = 'n';
plotSeisOld = 'n';
samplingSeis = 'a';
ylimSeis = 0;

plotGps = 'n';
stationsGps = 'MVO1,NWBL';
samplingGps = 'a';
errorsGps = 'a';
ylimGps = 0;

plotGas = 'n';
samplingGas = 'a';
errorsGas = 'a';
ylimGas = 0;

plotFumTemp = 'n';
nrmeanFumTemp = 1;
stationFumTemp = 'Mean';


plotDomeVol = 'n';
plotDomeExtr = 'n';

runMode = 'batch';
runLoudness = 'quiet';
filePlot = 'fig--megaplot3.png';

reFetchData = 'n';
titleOver = 'useDates';

