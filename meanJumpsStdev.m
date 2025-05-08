function [datetimeData, dataData, dataStddev] = meanJumpsStdev( datetimeData, dataData, dataStddev, tJump, datetimeBeg, datetimeEnd )

    if ~exist('datetimeBeg','var')
        datetimeBeg = datetimeData(1);
        datetimeEnd = datetimeData(end);
    end

    datetimeData2 = datetime([],[],[]);
    dataData2 = [];
    dataStddev2 = [];

    while datetimeBeg < datetimeEnd

        datetimeJump = datetimeBeg + days( tJump );

        idWant = datetimeData >= datetimeBeg & datetimeData < datetimeJump;

        if sum(idWant) >= 1
            datetimeData2(end+1) = mean( datetimeData(idWant), 'omitnan' );
            dataData2(end+1) = mean( dataData(idWant), 'omitnan' );
            dataStddev2(end+1) = sqrt( sum( dataStddev(idWant).^2 ) );
        else
            datetimeData2(end+1) = mean( datetimeData(idWant), 'omitnan' );
            dataData2(end+1) = NaN;
            dataStddev2(end+1) = NaN;
        end

        datetimeBeg = datetimeJump;

    end

    datetimeData = datetimeData2;
    dataData = dataData2;
    dataStddev = dataStddev2;

end