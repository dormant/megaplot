function ARGS = askArgs( sourceArgs )


    
    switch sourceArgs
        case 'd'
            sourceArgs = 'useDefaults';
        case 'e'
            sourceArgs = 'configWholeEruption.m';
        case '6m'
            sourceArgs = 'configLastSixMonths.m';
        case '1y'
            sourceArgs = 'configLastYear.m';
        case '2y'
            sourceArgs = 'configLastTwoYears.m';
        case '5y'
            sourceArgs = 'configLastFiveYears.m';
        case 'p5'
            sourceArgs = 'configPause5.m';
        case 't'
            sourceArgs = 'configTest.m';
        case 'webobs'
            sourceArgs = 'configMegaplotWebobs.m';
    end


    % Defaults

    dateBegDef = datetime( 1995, 1, 1 );
    dateNow = datetime;
    dateEndDef = dateshift( dateNow, 'end', 'day' );
    datimBegDef = datenum( dateBegDef );
    datimEndDef = datenum( dateEndDef );

    plotShapeDef = 's';
    plotSizeDef = 0;
    plotSize = plotSizeDef;
    plotSpacingDef = 'none';
    plotBackgroundDef = 'a';
    plotSubPhasesDef = 'n';
    plotFlowDef = 'v';

    plotSeisDef = 'y';
    plotSeisTypesDef = 'n';
    samplingSeisDef = 'a';
    plotSeisOldDef = 'a';
    ylimSeisDef = 0;

    plotGpsDef = 'y';
    stationsGpsDef = 'MVO1,NWBL';
    samplingGpsDef = 'a';
    errorsGpsDef = 'a';
    ylimGpsDef = 0;

    plotGasDef = 'y';
    samplingGasDef = 'a';
    errorsGasDef = 'a';
    ylimGasDef = 0;

    plotFumTempDef = 'n';
    nrmeanFumTempDef = 1;
    stationFumTempDef = 'Mean';

    plotDomeVolDef = 'n';
    plotDomeExtrDef = 'n';

    runModeDef = 'gui';
    runMode = runModeDef;
    runLoudnessDef = 'verbose';
    runLoudness = runLoudnessDef;
    fileBatchDef = '';             %%%%%%% CHECK WHY
    fileBatch = fileBatchDef;      %%%%%%%
    filePlotDef = 'fig--megaplot3.png';

    reFetchDataDef = 'n';
    titleOverDef = 'useDates';

   


    if strcmp( sourceArgs, 'useDefaults' )

            dateBeg = dateBegDef;
            dateEnd = dateEndDef;

            plotShape = plotShapeDef;
            plotSize = plotSizeDef;
            plotSpacing = plotSpacingDef;
            plotBackground = plotBackgroundDef;
            plotSubPhases = plotSubPhasesDef;
            plotFlow = plotFlowDef;
            filePlot = filePlotDef;

            plotSeis = plotSeisDef;
            plotSeisTypes = plotSeisTypesDef;
            plotSeisOld = plotSeisOldDef;
            samplingSeis = samplingSeisDef;
            ylimSeis = ylimSeisDef;

            plotGps = plotGpsDef;
            stationsGps = stationsGpsDef;
            samplingGps = samplingGpsDef;
            errorsGps = errorsGpsDef;
            ylimGps = ylimGpsDef;

            plotGas = plotGasDef;
            samplingGas = samplingGasDef;
            errorsGas = errorsGasDef;
            ylimGas = ylimGasDef;

            plotFumTemp = plotFumTempDef;
            nrmeanFumTemp = nrmeanFumTempDef;
            stationFumTemp = stationFumTempDef;

            plotDomeVol = plotDomeVolDef;
            plotDomeExtr = plotDomeExtrDef;

            reFetchData = reFetchDataDef;
            titleOver = titleOverDef;

    elseif endsWith( sourceArgs, ".m" )

        if strcmp( sourceArgs, 'configMegaplotWebobs.m' )
            fileBatch = "configDefaultsNothing.m";
        else
            fileBatch = "configDefaults.m";
        end
        run( fileBatch );
        fileBatch = sourceArgs;
        run( fileBatch );

    else

            [datimBeg, datimEnd] = askDates();
            dateBeg = datetime(datimBeg,'ConvertFrom','datenum')';
            dateEnd = datetime(datimEnd,'ConvertFrom','datenum')';

            plotShape = inputd( 'Plot shape (l|p|s|w|e)', 's', plotShapeDef );
            plotSize = inputd( 'Plot size (pixels of longest side)', 'i', plotSizeDef );
            plotSpacing = inputd( 'Plot layout (compact|tight|none)', 's', plotSpacingDef );
            plotBackground = inputd( 'Plot background (white|phases|phasescolour|a)', 's', plotBackgroundDef );
            plotSubPhases = inputd( 'Plot subphases (y|n)', 's', plotSubPhasesDef );
            plotFlow = inputd( 'Plot flow (h|v)', 's', plotFlowDef );
            filePlot = inputd( 'Name of plot file (no extension)', 's', filePlotDef );

            plotSeis = inputd( 'Plot seismic data (y|n)', 's', plotSeisDef );
            if strcmpi( plotSeis, 'y' )
                plotSeisTypes = inputd( 'Plot seismic event types (y|n|o|s)', 's', plotSeisTypesDef );
                plotSeisOld = inputd( 'Plot old seismic data (y|n|a)', 's', plotSeisTypesDef );
                samplingSeis = inputd( 'Resample seismic data (m|w|d|n|a)', 's', samplingSeisDef );
                ylimSeis = inputd( 'Limit seismic Y axis (ymax)', 'i', ylimSeisDef );
            else
                plotSeisTypes = 'n';
                plotSeisOld = 'n';
                samplingSeis = samplingSeisDef;
                ylimSeis = ylimSeisDef;
            end

            plotGps = inputd( 'Plot GPS data (y|n)', 's', plotGpsDef );
            if strcmpi( plotGps, 'y' )
                stationsGps = inputd( 'GPS stations to plot (comma-separated, no spaces)', 's', stationsGpsDef );
                samplingGps = inputd( 'Resample GPS data (m|w|d|n|a)', 's', samplingGpsDef );
                errorsGps = inputd( 'Show GPS errors (y|n|a)', 's', errorsGpsDef );
                ylimGps = inputd( 'Limit GPS Y axis (ymax)', 'i', ylimGpsDef );
            else
                stationsGps = stationsGpsDef;
                samplingGps = samplingGpsDef;
                errorsGps = errorsGpsDef;
                ylimGps = ylimGpsDef;
            end

            plotGas = inputd( 'Plot Gas data (y|n)', 's', plotGasDef );
            if strcmpi( plotGas, 'y' )
                samplingGas = inputd( 'Resample gas data (m|w|d|n|a)', 's', samplingGasDef );
                errorsGas = inputd( 'Show gas errors (y|n|a)', 's', errorsGasDef );
                ylimGas = inputd( 'Limit gas Y axis (ymax)', 'i', ylimGasDef );
            else
                samplingGas = samplingGasDef;
                errorsGas = errorsGasDef;
                ylimGas = ylimGasDef;
            end

            plotFumTemp = inputd( 'Plot fumarole temperatures (y|n)', 's', plotFumTempDef );
            if strcmpi( plotFumTemp, 'y' )
                nrmeanFumTemp = inputd( 'running mean for fumarole data', 'i', nrmeanFumTempDef );
                stationFumTemp  = inputd( 'Fumarole temperates to plot', 's', stationFumTempDef );
            else
                nrmeanFumTemp = nrmeanFumTempDef;
                stationFumTemp  = stationFumTempDef;
            end

            plotDomeVol = inputd( 'Plot dome volume (y|n)', 's', plotDomeVolDef );
            plotDomeExtr = inputd( 'Plot extrusion rate (y|n)', 's', plotDomeExtrDef );

            titleOver = inputd( 'Title', 's', titleOverDef );

            reFetchData = inputd( 'Refetch source data (y|n)', 's', reFetchDataDef );
    


    end

    dateBeg = datetime(datenum(dateBeg),'ConvertFrom','datenum');
    dateEnd = datetime(datenum(dateEnd),'ConvertFrom','datenum');
    
    durationDays = split( between(dateBeg,dateEnd,'Days'), 'days' );
    if durationDays > 7300
        if strcmp( samplingSeis, 'a' )
            samplingSeis = 'm';
        end
        if strcmp( samplingGps, 'a' )
            samplingGps = 'm';
        end
        if strcmp( samplingGas, 'a' )
            samplingGas = 'm';
        end
        if strcmp( errorsGps, 'a' )
            errorsGps = 'n';
        end
        if strcmp( errorsGas, 'a' )
            errorsGas = 'n';
        end
    elseif durationDays > 366
        if strcmp( samplingSeis, 'a' )
            samplingSeis = 'w';
        end
        if strcmp( samplingGps, 'a' )
            samplingGps = 'w';
        end
        if strcmp( samplingGas, 'a' )
            samplingGas = 'w';
        end
        if strcmp( errorsGps, 'a' )
            errorsGps = 'n';
        end
        if strcmp( errorsGas, 'a' )
            errorsGas = 'n';
        end
    else
        if strcmp( samplingSeis, 'a' )
            samplingSeis = 'n';
        end
        if strcmp( samplingGps, 'a' )
            samplingGps = 'n';
        end
        if strcmp( samplingGas, 'a' )
            samplingGas = 'n';
        end
        if strcmp( errorsGps, 'a' )
            errorsGps = 'y';
        end
        if strcmp( errorsGas, 'a' )
            errorsGas = 'y';
        end
    end

    if strcmpi( plotBackground, 'a' )
        if durationDays > 7300
            plotBackground = 'phases';
        else
            plotBackground = 'white';
        end
    end



    ARGS = v2struct( runMode, runLoudness, fileBatch, filePlot, dateBeg, dateEnd, ...
        plotShape, plotSize, plotSpacing, plotBackground, plotSubPhases, plotFlow, ...
        plotSeis, plotGps, plotGas, ...
        plotSeisTypes, plotSeisOld, samplingSeis, ylimSeis, ...
        stationsGps, samplingGps, errorsGps, ylimGps, ...
        samplingGas, errorsGas, ylimGas, ...
        plotDomeVol, plotDomeExtr, plotFumTemp, ...
        durationDays, reFetchData, titleOver, ...
        nrmeanFumTemp, stationFumTemp );

end