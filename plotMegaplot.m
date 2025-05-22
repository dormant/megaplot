function plotMegaplot(varargin)
% plotMegaplot 
% version 3
%
% Rod Stewart, UWI/SRC/MVO, 2024-10-23F
%



% ============================== Startup
clearvars -except varargin;
if ~desktop('-inuse')
    addpath(genpath('/home/seisan/src/MATLAB'));
end
setup = setupGlobals();
setColours;
nVarargs = length(varargin);
switch nVarargs
    case 0
        sourceArgs = 'ask';
    otherwise
        sourceArgs = varargin{1};
end
ARGS = askArgs( sourceArgs );
dirCurrent = cd( fullfile( setup.DirHome, 'src/megaplot' ) );



% ============================== Set options, etc
runMode = string( extractfield( ARGS, 'runMode' ) );
runLoudness = string( extractfield( ARGS, 'runLoudness' ) );
fileBatch = string( extractfield( ARGS, 'fileBatch' ) );
filePlot = string( extractfield( ARGS, 'filePlot' ) );

dateBeg = datetime(string(extractfield( ARGS, 'dateBeg' )));
dateEnd = datetime(string(extractfield( ARGS, 'dateEnd' )));
tLimits = [ dateBeg dateEnd ];

plotShape = string( extractfield( ARGS, 'plotShape' ) );
plotSize = extractfield( ARGS, 'plotSize' );
plotSpacing = string( extractfield( ARGS, 'plotSpacing' ) );
plotBackground = string( extractfield( ARGS, 'plotBackground' ) );
plotSubPhases = string( extractfield( ARGS, 'plotSubPhases' ) );
plotFlow = string( extractfield( ARGS, 'plotFlow' ) );

plotSeisTypes = string( extractfield( ARGS, 'plotSeisTypes' ) );
plotSeisOld = string( extractfield( ARGS, 'plotSeisOld' ) );
samplingSeis = string( extractfield( ARGS, 'samplingSeis' ) );
ylimSeis = extractfield( ARGS, 'ylimSeis' );

stationsGps = string( extractfield( ARGS, 'stationsGps' ) );
samplingGps = string( extractfield( ARGS, 'samplingGps' ) );
errorsGps = string( extractfield( ARGS, 'errorsGps' ) );
ylimGps = extractfield( ARGS, 'ylimGps' );

samplingGas = string( extractfield( ARGS, 'samplingGas' ) );
errorsGas = string( extractfield( ARGS, 'errorsGas' ) );
ylimGas = extractfield( ARGS, 'ylimGas' );

nrmeanFumTemp  = extractfield( ARGS, 'nrmeanFumTemp' );
stationFumTemp  = string( extractfield( ARGS, 'stationFumTemp' ) );

plotSeis = string( extractfield( ARGS, 'plotSeis' ) );
plotGps = string( extractfield( ARGS, 'plotGps' ) );
plotGas = string( extractfield( ARGS, 'plotGas' ) );
plotFumTemp = string( extractfield( ARGS, 'plotFumTemp' ) );
plotDomeVol = string( extractfield( ARGS, 'plotDomeVol' ) );
plotDomeExtr = string( extractfield( ARGS, 'plotDomeExtr' ) );
reFetchData = string( extractfield( ARGS, 'reFetchData' ) );
titleOver = string( extractfield( ARGS, 'titleOver' ) );

durationDays = extractfield( ARGS, 'durationDays' );

if plotSize > 0
    markerSize = 4;
    markerSizeSmall = 4;
else
    markerSize = 7;
    markerSizeSmall = 4;
end


if strcmpi( plotSeisOld, 'a' )
    if dateBeg > datetime(1996,10,28)
        plotSeisOld = 'n';
    else
        plotSeisOld = 'y';
    end
end
% ------------------------------ End set options, etc


% ============================== Print run info
if ~strcmp( runLoudness, 'quiet' )
    fprintf( "plotMegaplot v3    %s    %s\n",  datetime("now"),  runMode );
end
infoRun = sprintf( "plotMegaplot v3    %s    %s",  datetime("now"),  runMode );



% ============================== Refetch data
if strcmp( reFetchData, 'y' )
    reFetchAll( setup ); 
end



% ============================== Sort tiles and tile order
tilesWhat = {};
if strcmpi( plotSeis, 'y' )
    if strcmpi( plotSeisTypes, 'y' )
        tilesWhat = { 'seisVT', 'seisALLLP', 'seisALLRF' };
    elseif strcmpi( plotSeisTypes, 'o' )
        tilesWhat = { 'seisVT', 'seisHY', 'seisLP', 'seisRO', 'seisLR' };
    elseif strcmpi( plotSeisTypes, 's' )
        tilesWhat = { 'seisVTNST', 'seisVTSTR' };
    else
        tilesWhat = { 'seisALL' };
    end
end

if strcmpi( plotGps, 'y' )
    tilesWhat{end+1} = 'gps';
end
if strcmpi( plotGas, 'y' )
    tilesWhat{end+1} = 'gas';
end
if strcmpi( plotFumTemp, 'y' )
    tilesWhat{end+1} = 'ftemp';
end
if strcmpi( plotDomeVol, 'y' )
    tilesWhat{end+1} = 'dvol';
end
if strcmpi( plotDomeExtr, 'y' )
    tilesWhat{end+1} = 'dextr';
end

tilesN = length( tilesWhat );
tilesOrder = 1:tilesN;
% ------------------------------ End sort tiles and tile order



% ============================== Load seismic data
% OLD data
load( 'data/seismic/eq_counts' );
sdata = get( eq_counts.OldAll, 'Data' );
tdata = get( eq_counts.OldAll, 'Time' );
tstart = datenum( eq_counts.TimeInfo.StartDate );
tdata = tdata + tstart - 1;
datetimeOLD = datetime(tdata,'ConvertFrom','datenum');
idPlot = datetimeOLD >= dateBeg & datetimeOLD < dateEnd;
datetimeOLD = datetimeOLD( idPlot );
dataOLD = sdata( idPlot );

data_file = fullfile( setup.DirMegaplotData, 'fetchedCountVolcstat.mat' );
load( data_file );

dataALL = [CountVolcstatALL.data]; %%%%%%%%%%% Check if this is ALL or ALLVOLC
datim = [CountVolcstatALL.datim];
datetimeALL = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeALL >= dateBeg & datetimeALL < dateEnd;
dataALL = dataALL( idPlot );
datetimeALL = datetimeALL( idPlot );

dataVT = [CountVolcstatVT.data];
datim = [CountVolcstatVT.datim];
datetimeVT = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeVT >= dateBeg & datetimeVT < dateEnd;
dataVT = dataVT( idPlot );
datetimeVT = datetimeVT( idPlot );

dataALLLP = [CountVolcstatALLLP.data];
datim = [CountVolcstatALLLP.datim];
datetimeALLLP = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeALLLP >= dateBeg & datetimeALLLP < dateEnd;
dataALLLP = dataALLLP( idPlot );
datetimeALLLP = datetimeALLLP( idPlot );

dataALLRF = [CountVolcstatALLRF.data];
datim = [CountVolcstatALLRF.datim];
datetimeALLRF = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeALLRF >= dateBeg & datetimeALLRF < dateEnd;
dataALLRF = dataALLRF( idPlot );
datetimeALLRF = datetimeALLRF( idPlot );

dataHY = [CountVolcstatHY.data];
datim = [CountVolcstatHY.datim];
datetimeHY = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeHY >= dateBeg & datetimeHY < dateEnd;
dataHY = dataHY( idPlot );
datetimeHY = datetimeHY( idPlot );

dataLP = [CountVolcstatLP.data];
datim = [CountVolcstatLP.datim];
datetimeLP = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeLP >= dateBeg & datetimeLP < dateEnd;
dataLP = dataLP( idPlot );
datetimeLP = datetimeLP( idPlot );

dataRO = [CountVolcstatRO.data];
datim = [CountVolcstatRO.datim];
datetimeRO = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeRO >= dateBeg & datetimeRO < dateEnd;
dataRO = dataRO( idPlot );
datetimeRO = datetimeRO( idPlot );

dataLR = [CountVolcstatLR.data];
datim = [CountVolcstatLR.datim];
datetimeLR = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeLR >= dateBeg & datetimeLR < dateEnd;
dataLR = dataLR( idPlot );
datetimeLR = datetimeLR( idPlot );

dataVTNST = [CountVolcstatVTNST.data];
datim = [CountVolcstatVTNST.datim];
datetimeVTNST = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeVTNST >= dateBeg & datetimeVTNST < dateEnd;
dataVTNST = dataVTNST( idPlot );
datetimeVTNST = datetimeVTNST( idPlot );

dataVTSTR = [CountVolcstatVTSTR.data];
datim = [CountVolcstatVTSTR.datim];
datetimeVTSTR = datetime(datim,'ConvertFrom','datenum');
idPlot = datetimeVTSTR >= dateBeg & datetimeVTSTR < dateEnd;
dataVTSTR = dataVTSTR( idPlot );
datetimeVTSTR = datetimeVTSTR( idPlot );

% ------------------------------ End load seismic data



% ============================== Load GPS data
load( 'data/gps/gps1' );
g0data = get( gps1, 'Data' );
t0data = get( gps1, 'Time' );
tstart = datenum( gps1.TimeInfo.StartDate );
t0data = t0data + tstart - 1;
datetimedata = datetime(t0data,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
g0data = g0data(idPlot);
g0data = g0data - mean( g0data, 'omitnan' );
datetimeGpsGm = datetimedata';
dataGpsGm = g0data';

load( '/home/seisan/src/megaplot/data/gps/gps_auto_final_all.mat');
stasGps = split( stationsGps, ',' );
nstaGps = size(stasGps,1);
for ista = 1: nstaGps
    stat = stasGps(ista);
    comp = 'r';
    statcomp = sprintf( "%s_%s", stat, comp );
    g2data = get( gps_auto.(statcomp), 'Data' );
    t2data = get( gps_auto.(statcomp), 'Time' );
    tstart = datenum( gps_auto.(statcomp).TimeInfo.StartDate );
    t2data = t2data + tstart - 1;
    e2data = get( gps_auto_err.(statcomp), 'Data');
    datetimedata = datetime(t2data,'ConvertFrom','datenum')';
    idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
    datetimedata = datetimedata(idPlot);
    g2data = g2data(idPlot);
    g2data = g2data - mean( g2data, 'omitnan' );
    e2data = e2data(idPlot);
    datetimeGps(ista,:) = datetimedata';
    dataGps(ista,:) = g2data';
    errGps(ista,:) = e2data';
    staGps(ista) = stat;
end
dataGps = dataGps*1000.0;
errGps = errGps*1000.0;
% ------------------------------ End load GPS data



% ============================== Load Gas data
load( 'data/gas/gas_so2_auto' );
gdata = get( gas_so2, 'Data' );
tdata = get( gas_so2, 'Time' );
tstart = datenum( gas_so2.TimeInfo.StartDate );
% change by PJS 31-08-2011 - removed -1 as discovered a 1 day offset
tdata = tdata + tstart;% - 1;
datetimedata = datetime(tdata,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
gdata = gdata(idPlot);
datetimeGas = datetimedata';
dataGas = gdata';
begDoas = datetime( datenum('01-Jan-2002'),'ConvertFrom','datenum');
begNewDoas =  datetime( datenum('01-Jan-2017'),'ConvertFrom','datenum');
idxCospec = datetimedata < begDoas;
idxDoas= datetimedata >= begDoas & datetimedata < begNewDoas;
idxNewDoas = datetimedata >= begNewDoas;
load('data/gas/gas_so2_traverse.mat');
gasDays = gas_dates;
gasVals = gas_so2_trav;
gasErrs = gas_err;
datetimedata = datetime(gasDays,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
gasVals = gasVals(idPlot);
gasErrs = gasErrs(idPlot);
datetimeGasTraverse = datetimedata';
dataGasTraverse = gasVals';
errGasTraverse = gasErrs';
% ------------------------------ End load Gas data



% ============================== Load fumarole temperature data
load( 'data/fumarole_temps/fumarole_temps.mat' );
datetimedata = datetime(fdatim,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
fdata = fdata(idPlot);
datetimeFum = datetimedata';
dataFum = fdata';
% ------------------------------ End load fumarole temperature data



% ============================== Load dome data
data_file = 'data/dome/extr.mat';
load( data_file );
dataExtrRate = get( extr_rate, 'Data' );
datimExtrRate = get( extr_rate, 'Time' );
datetimedata = datetime(datimExtrRate,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
dataExtrRate = dataExtrRate(idPlot);
datetimeDomeExtr = datetimedata';
dataDomeExtr = dataExtrRate';
idInf = isinf( dataDomeExtr );
dataDomeExtr( idInf) = NaN;
datetimedata = datetime(datimVolume,'ConvertFrom','datenum')';
idPlot = datetimedata >= dateBeg & datetimedata < dateEnd;
datetimedata = datetimedata(idPlot);
dataVolume = dataVolume(idPlot);
datetimeDomeVol = datetimedata';
dataDomeVol = dataVolume';
% ------------------------------ End load dome data



% ============================== Resample data

% ============================== Resample seismic data
switch samplingSeis
    case 'm'
        sampIntervalSeis = 'Month';
        nDownsample = 31;
    case 'w'
        sampIntervalSeis = 'Week';
        nDownsample = 7;
    otherwise
        sampIntervalSeis = 'Day';
        nDownsample = 0;
end
if nDownsample > 0
    [datetimeALL, dataALL] = reBin( datetimeALL, dataALL, nDownsample );
    [datetimeVT, dataVT] = reBin( datetimeVT, dataVT, nDownsample );
    [datetimeALLLP, dataALLLP] = reBin( datetimeALLLP, dataALLLP, nDownsample );
    [datetimeALLRF, dataALLRF] = reBin( datetimeALLRF, dataALLRF, nDownsample );
    [datetimeOLD, dataOLD] = reBin( datetimeOLD, dataOLD, nDownsample );
    [datetimeHY, dataHY] = reBin( datetimeHY, dataHY, nDownsample );
    [datetimeLP, dataLP] = reBin( datetimeLP, dataLP, nDownsample );
    [datetimeLR, dataLR] = reBin( datetimeLR, dataLR, nDownsample );
    [datetimeRO, dataRO] = reBin( datetimeRO, dataRO, nDownsample );
    [datetimeVTNST, dataVTNST] = reBin( datetimeVTNST, dataVTNST, nDownsample );
    [datetimeVTSTR, dataVTSTR] = reBin( datetimeVTSTR, dataVTSTR, nDownsample );
end

% ============================== Resample gps data
switch samplingGps
    case 'm'
        sampIntervalGps = 'Monthly';
        nDownsample = 31;
    case 'w'
        sampIntervalGps = 'Weekly';
        nDownsample = 7;
    otherwise
        sampIntervalGps = '';
        nDownsample = 0;
end
if nDownsample > 0
    tmp = datetimeGps';
    tmp = downsample(tmp,nDownsample);
    datetimeGps = tmp';
    tmp = dataGps';
    tmp = downsample(tmp,nDownsample);
    dataGps = tmp';
    if sum(dataGpsGm,'omitnan') > 0
        [datetimeGpsGm,dataGpsGm] = meanJumps( datetimeGpsGm, dataGpsGm, nDownsample );
    end
end

% ============================== Resample gas data
switch samplingGas
    case 'm'
        sampIntervalGas = 'Monthly';
        nDownsample = 31;
    case 'w'
        sampIntervalGas = 'Weekly';
        nDownsample = 7;
    otherwise
        sampIntervalGas = '';
        nDownsample = 0;
end
if nDownsample > 0
    if sum(dataGas,'omitnan') > 0
        [datetimeGas,dataGas] = meanJumps( datetimeGas, dataGas, nDownsample );
    end
    if sum(dataGasTraverse,'omitnan') > 0
        [datetimeGasTraverse, dataGasTraverse, errGasTraverse] = meanJumpsStdev( datetimeGasTraverse, dataGasTraverse, errGasTraverse, nDownsample );
    end
    idxCospec = datetimeGas < begDoas;
    idxDoas= datetimeGas >= begDoas & datetimeGas < begNewDoas;
    idxNewDoas = datetimeGas >= begNewDoas;
end

% ============================== Smooth fumarole temperature data
if nrmeanFumTemp > 1
    dataFum = movmean( dataFum, nrmeanFumTemp);
end

% ------------------------------ End resample data



% ============================== Get max and mins
maxSeisOLD = maxMaybeEmpty( dataOLD );
minSeisOLD = minMaybeEmpty( dataOLD );
maxSeisALL = maxMaybeEmpty( dataALL);
minSeisALL = minMaybeEmpty( dataALL);
maxSeisALL = max( maxSeisALL, maxSeisOLD );
minSeisALL = min( minSeisALL, minSeisOLD );
%maxSeisVT = maxMaybeEmpty( dataVT );
%minSeisVT = minMaybeEmpty( dataVT );
%maxSeisVT = max( maxSeisVT, maxSeisOLD );
%minSeisVT = min( minSeisVT, minSeisOLD );
maxSeisVT = 410;
minSeisVT = 0;
maxSeisALLLP = maxMaybeEmpty( dataALLLP );
minSeisALLLP = minMaybeEmpty( dataALLLP );
maxSeisALLRF = maxMaybeEmpty( dataALLRF );
minSeisALLRF = minMaybeEmpty( dataALLRF );
maxSeisHY = maxMaybeEmpty( dataHY );
minSeisHY = minMaybeEmpty( dataHY );
maxSeisLP = maxMaybeEmpty( dataLP );
minSeisLP = minMaybeEmpty( dataLP );
maxSeisRO = maxMaybeEmpty( dataRO );
minSeisRO = minMaybeEmpty( dataRO );
maxSeisLR = maxMaybeEmpty( dataLR );
minSeisLR = minMaybeEmpty( dataLR );
maxSeisVTNST = maxMaybeEmpty( dataVTNST );
minSeisVTNST = minMaybeEmpty( dataVTNST );
maxSeisVTSTR = maxMaybeEmpty( dataVTSTR );
minSeisVTSTR = minMaybeEmpty( dataVTSTR );
maxGps = maxMaybeEmpty(dataGps);
minGps = minMaybeEmpty(dataGps);
maxGpsGm = maxMaybeEmpty( max(dataGpsGm) );
minGpsGm = minMaybeEmpty( min(dataGpsGm) );
maxGps = max( maxGps, maxGpsGm );
minGps = min( minGps, minGpsGm );
maxGas = maxMaybeEmpty(dataGas);
minGas = minMaybeEmpty(dataGas);
maxGasTraverse = maxMaybeEmpty(dataGasTraverse);
minGasTraverse = minMaybeEmpty(dataGasTraverse);
maxGas = max( maxGas, maxGasTraverse );
minGas = min( minGas, minGasTraverse );
maxFum = max( dataFum);
minFum = min( dataFum);
maxDomeVol = maxMaybeEmpty(dataDomeVol);
minDomeVol = minMaybeEmpty(dataDomeVol);
maxDomeExtr = maxMaybeEmpty(dataDomeExtr);
minDomeExtr = minMaybeEmpty(dataDomeExtr);
yLimMult = 1.1;
% ------------------------------ End get max and mins



% ============================== Plot
if strcmp( runMode, "gui" )
    figure;
else
    figure('visible','off');
end
figure_size( plotShape, plotSize );
if strcmpi( plotFlow, 'h' )
    tiledlayout( 1, tilesN, 'TileSpacing', plotSpacing );
else
    tiledlayout( tilesN, 1, 'TileSpacing', plotSpacing );
end
col = { '#ef476f', '#06d6a0', '#ffd166', '#118ab2', '#fb8500' };
if plotSize > 0
    errorCapSize = 2;
else
    errorCapSize = 4;
end


% ============================== Plot tiles
for iTile = 1:tilesN
    
    tileNumber = tilesOrder(iTile);
    tileWhat = string( tilesWhat(iTile) );
    
    ax(iTile) = nexttile( tileNumber );

% ============================== Plot seismic tile
    if contains( tileWhat, 'seis' )
        switch tileWhat
            case 'seisALL'
                datetimeSeis = datetimeALL;
                dataSeis = dataALL;   
                maxSeis = maxSeisALL;
                yTitle = sprintf( "Seismic Events / %s", sampIntervalSeis );
            case 'seisVT'
                datetimeSeis = datetimeVT;
                dataSeis = dataVT;                
                maxSeis = maxSeisVT;
                yTitle = sprintf( "VTs / %s", sampIntervalSeis );
            case 'seisALLLP'
                datetimeSeis = datetimeALLLP;
                dataSeis = dataALLLP;                
                maxSeis = maxSeisALLLP;
                yTitle = sprintf( "LFs / %s", sampIntervalSeis );
                plotSeisOld = 'n';
           case 'seisALLRF'
                datetimeSeis = datetimeALLRF;
                dataSeis = dataALLRF;                
                maxSeis = maxSeisALLRF;
                yTitle = sprintf( "RFs / %s", sampIntervalSeis );
                plotSeisOld = 'n';
           case 'seisHY'
                datetimeSeis = datetimeHY;
                dataSeis = dataHY;                
                maxSeis = maxSeisHY;
                yTitle = sprintf( "Hybrids / %s", sampIntervalSeis );
                plotSeisOld = 'n';
           case 'seisLP'
                datetimeSeis = datetimeLP;
                dataSeis = dataLP;                
                maxSeis = maxSeisLP;
                yTitle = sprintf( "LPs / %s", sampIntervalSeis );
                plotSeisOld = 'n';
           case 'seisLR'
                datetimeSeis = datetimeLR;
                dataSeis = dataLR;                
                maxSeis = maxSeisLR;
                yTitle = sprintf( "LP/rockfalls / %s", sampIntervalSeis );
                plotSeisOld = 'n';
           case 'seisRO'
                datetimeSeis = datetimeRO;
                dataSeis = dataRO;                
                maxSeis = maxSeisRO;
                yTitle = sprintf( "Rockfalls / %s", sampIntervalSeis );
                plotSeisOld = 'n';
           case 'seisVTNST'
                datetimeSeis = datetimeVTNST;
                dataSeis = dataVTNST;                
                maxSeis = maxSeisVTNST;
                yTitle = sprintf( "Non-string VTs / %s", sampIntervalSeis );
                plotSeisOld = 'n';
           case 'seisVTSTR'
                datetimeSeis = datetimeVTSTR;
                dataSeis = dataVTSTR;                
                maxSeis = maxSeisVTSTR;
                yTitle = sprintf( "String VTs / %s", sampIntervalSeis );
                plotSeisOld = 'n';
        end
        bar( datetimeSeis, dataSeis, 1.0, 'r' );
        if strcmpi( plotSeisOld, 'y' )
            hold on;
            bar( datetimeOLD, dataOLD, 1.0, 'k' );
            lgd = legend( {'SEISAN','pre-SEISAN'}, 'Location', 'northwest' );
            fontsize(lgd,'decrease');
        end
        ylim( [0 maxSeis] * yLimMult );
        

% ============================== Plot GPS tile
    elseif contains( tileWhat, 'gps')

        hold on;
        itemsLegend = {};
        if abs(sum(dataGpsGm,'omitnan')) > 0
            plot( datetimeGpsGm, dataGpsGm, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k', 'MarkerSize', markerSizeSmall );
            itemsLegend{end+1} = 'HARR vertical (campaign)';   
        end
        for ista = 1:nstaGps
            if abs(sum(dataGps(ista,:),'omitnan')) > 0
                if strcmpi( errorsGps, 'y' )
                    e = errorbar( datetimeGps(ista,:), dataGps(ista,:), errGps(ista,:), '.','Color', col{ista}, 'HandleVisibility','off');
                    e.CapSize = errorCapSize;
                end
                plot( datetimeGps(ista,:), dataGps(ista,:), 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', col{ista}, 'MarkerSize', markerSize );
                itemsLegend{end+1} = sprintf( "%s radial", staGps(ista) );
            end
        end
        lgd = legend( itemsLegend, 'Location', 'northwest' );
        fontsize(lgd,'decrease')
        switch sampIntervalGps
            case ''
                yTitle = 'GPS Distance (mm)';
            otherwise
                yTitle1 = sprintf( "%s Mean", sampIntervalGps );
                yTitle = {yTitle1," GPS Distance (mm)"};
        end
        if ylimGps == 0
            ylim( [minGps maxGps] * yLimMult );
        else
            ylim( [-1*ylimGps ylimGps] );
        end

% ============================== Plot Gas tile
    elseif contains( tileWhat, 'gas')
        itemsLegend = {};
        hold on;
        % Plot COSPEC
        if sum(idxCospec) > 0
            colourGas = col{3};
            plot( datetimeGas(idxCospec), dataGas(idxCospec), 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colourGas, 'MarkerSize', markerSize );
            itemsLegend{end+1} = 'COSPEC';
        end
        % Plot DOAS
        if sum(idxDoas) > 0
            colourGas = col{2};
            plot( datetimeGas(idxDoas), dataGas(idxDoas), 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colourGas, 'MarkerSize', markerSize );
            itemsLegend{end+1} = 'DOAS';
        end
        % Plot traverses
        if sum(dataGasTraverse,'omitnan') > 0
            colourGas = col{1};
            if strcmpi( errorsGas, 'y' )
                e = errorbar( datetimeGasTraverse, dataGasTraverse, errGasTraverse, '.','Color', colourGas, 'HandleVisibility','off');
                e.CapSize = errorCapSize;
            end
            plot( datetimeGasTraverse, dataGasTraverse, 'o', 'MarkerEdgeColor', 'k', 'MarkerFaceColor', colourGas, 'MarkerSize', markerSize );
            itemsLegend{end+1} = 'Traverse';
        end
        lgd = legend( itemsLegend, 'Location', 'northwest' );
        fontsize(lgd,'decrease')
        if ylimGas == 0
            ylim( [0 maxGas] * yLimMult );
        else
            ylim( [0 ylimGas] );
        end
        switch sampIntervalGas
            case ''
                yTitle = 'SO_{2} (tonnes/day)';
            otherwise
                yTitle1 = sprintf( "%s Mean SO_{2}", sampIntervalGas );
                yTitle = {yTitle1, '(tonnes/day)'};
        end


% ============================== Plot fumarole temperature tile
    elseif contains( tileWhat, 'ftemp')
        hold on;
        if sum(dataFum,'omitnan') > 0
            colourFum = col{5};
            plot( datetimeFum, dataFum, 'o', 'MarkerEdgeColor', colourFum, 'MarkerFaceColor', colourFum, 'MarkerSize', markerSize );
            ylim( [minFum/yLimMult maxFum*yLimMult] );
            yTitle = {'Average Maximum', 'Fumarole Temperature (^{o}C)' };
            if nrmeanFumTemp > 1
                legItems = sprintf( "%s %d-point running mean", stationFumTemp, nrmeanFumTemp );
            else
                legItems = stationFumTemp;
            end
            legend( legItems, 'Location', 'northwest' );
            
        end


% ============================== Plot dome volume
    elseif contains( tileWhat, 'dvol')
        hold on;
        if sum(dataDomeVol,'omitnan') > 0
            colourDome = 'k';
            plot( datetimeDomeVol, dataDomeVol, 'o', 'MarkerEdgeColor', colourDome, 'MarkerFaceColor', colourDome, 'MarkerSize', markerSizeSmall );
            yTitle = 'Dome Volume (m^{3})';
        end
        ylim( [0 maxDomeVol] * yLimMult );


% ============================== Plot dome extrusion rate
    elseif contains( tileWhat, 'dextr')
        hold on;
        if sum(dataDomeExtr,'omitnan') > 0
            colourDome = 'k';
            plot( datetimeDomeExtr, dataDomeExtr, 'o', 'MarkerEdgeColor', colourDome, 'MarkerFaceColor', colourDome, 'MarkerSize', markerSizeSmall );
            yTitle = 'Extrusion Rate (???)';
        end
        ylim( [0 maxDomeExtr] * yLimMult );


% ------------------------------ End plot tiles
    end



% ============================== Modify tile
    %set(gca,'TickDir','out');
    if contains( plotSpacing, {'none','tight'} )
        if tileNumber == 1
            if strcmpi( plotFlow, 'h' )
                set( gca, 'XAxisLocation', 'bottom' );
            else
                set( gca, 'XAxisLocation', 'top' );
                xlabel( 'Date (UTC)' );
            end
        elseif tileNumber == tilesN
            if strcmpi( plotFlow, 'h' )
                set( gca, 'XAxisLocation', 'top' );
            else
                set( gca, 'XAxisLocation', 'bottom' );
                xlabel( 'Date (UTC)' );
            end
        else
            set( gca, 'XTickLabel', {} );
        end
    elseif contains( plotSpacing, 'compact' )
        if tileNumber == tilesN
            xlabel( 'Date (UTC)' );
        end
    end
    yLimits = ylim;
    yTicks = get(gca,'yTick');
    if yTicks(end) == yLimits(2)
        set(gca,'yTick',yTicks(1:end-1));
    end
    ylabel( yTitle );
    if plotSize == 0
        fontsize(ax(iTile),scale=1.5);
    end
    fontsize(ax(iTile).YAxis,scale=0.8);

    switch plotBackground
        case 'phases'
            plotPhases( yLimits, plotSubPhases, false );
        case 'phasescolour'
            plotPhases( yLimits, plotSubPhases, true );
    end

    hold on;
    xTicks = get(gca,'xTick');
    xline( xTicks, ":", 'HandleVisibility','off' );

    if strcmpi( plotFlow, 'h' )
        set( gca, 'YAxisLocation', 'right' );
        view([90 -90]);
        set (gca,'Xdir','reverse');
    end



end
% ------------------------------ End plot tiles



% ============================== Modify plot
linkaxes( ax, 'x' );
ax(1).XLim = tLimits;
% ------------------------------ End modify plot



% ============================== Overtitle and run info
if ~strcmp( titleOver, 'none' )
    if strcmp( titleOver, 'useDates' )
        dateBeg.Format = "d/M/yyyy";
        dateEnd.Format = "d/M/yyyy";
        titleOver = sprintf( "%s to %s", dateBeg, dateEnd );
    end
    hot = plotOverTitle( titleOver );
    if plotSize == 0
        fontsize(hot,scale=1.5);
    end
    hot.FontWeight = 'normal';
end

an = annotation('textbox', [0.02, 0.02, 0.2, 0.015], 'string', infoRun, ...
    'FitBoxToText','on', ...
    'BackgroundColor', [.9 .9 .9] );
if plotSize > 0
    fontsize(an,scale=0.5);
end



% ============================== Save plot
if strcmp( filePlot, 'fig--megaplot3.png' )
    dateBeg.Format = "yyyyMMdd";
    dateEnd.Format = "yyyyMMdd";
    filePlot = sprintf( "fig--megaplot3--%s-%s--%d.png", dateBeg, dateEnd, tilesN );
end
saveas( gcf, filePlot );



% ============================== Go home
cd( dirCurrent );


