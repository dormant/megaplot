function plotPhases( yLimits, plotSubPhases, inColor )

    if inColor
        colourBack = [211 222 174] / 255;
        colourFront = [255 192 203] / 255;
        colourBox = 'k';
    else
        colourBack = [ 1 1 1 ];
        colourFront = [ .8 .8 .8 ];
        colourBox = 'k';
    end
    
    
    ybox1 = yLimits(1);
    ybox2 = yLimits(2);
    Ypatch = [ybox1 ybox2 ybox2 ybox1 ];

    stringSubPhases = 'abc';

    for iphase = 1:5
        
        if iphase == 2
            nsubphase = 3;
        elseif iphase == 4
            nsubphase = 2;
        else
            nsubphase = 0;
        end

        if strcmpi( plotSubPhases, 'n' ) || nsubphase == 0

            begBox = sprintf( 'begPhase%1d', iphase );
            endBox = sprintf( 'begPause%1d', iphase );
            xbox1 = datetime( dateCommon( begBox ), 'ConvertFrom','datenum');
            xbox2 = datetime( dateCommon( endBox ), 'ConvertFrom','datenum');
            Xpatch = [ xbox1 xbox1 xbox2 xbox2 ];
            hold on;
            axp = patch( Xpatch, Ypatch, colourFront, 'EdgeColor', colourBox, 'HandleVisibility','off' );
            uistack(axp,'bottom');

        else

            for isubphase = 1:nsubphase
                begBox = sprintf( 'begPhase%1d%1s', iphase, stringSubPhases(isubphase) );
                endBox = sprintf( 'begPause%1d%1s', iphase, stringSubPhases(isubphase) );
                xbox1 = datetime( dateCommon( begBox ), 'ConvertFrom','datenum');
                xbox2 = datetime( dateCommon( endBox ), 'ConvertFrom','datenum');
                Xpatch = [ xbox1 xbox1 xbox2 xbox2 ];
                hold on;
                axp = patch( Xpatch, Ypatch, colourFront, 'EdgeColor', colourBox, 'HandleVisibility','off' );
                uistack(axp,'bottom');
            end

        end
    
    end

    xbox1 = datetime( datenum( 1995, 1, 1, 0, 0, 0 ), 'ConvertFrom','datenum');
    xbox2 = datetime( dateCommon( 'now' ), 'ConvertFrom','datenum');
    Xpatch = [ xbox1 xbox1 xbox2 xbox2 ];
    axp = fill( Xpatch, Ypatch, colourBack, 'EdgeColor', colourBox, 'HandleVisibility','off' );
    uistack(axp,'bottom');
    

end