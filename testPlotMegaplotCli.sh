#!/usr/bin/bash

matlab -nosplash -nodisplay -r "plotMegaplot( 'configLastFiveYears.m'); quit" > /dev/null 2>&1
matlab -nosplash -nodisplay -r "plotMegaplot( 'configLastSixMonths.m'); quit" > /dev/null 2>&1
matlab -nosplash -nodisplay -r "plotMegaplot( 'configLastTwoYears.m'); quit" > /dev/null 2>&1
matlab -nosplash -nodisplay -r "plotMegaplot( 'configLastYear.m'); quit" > /dev/null 2>&1
matlab -nosplash -nodisplay -r "plotMegaplot( 'configPause5.m'); quit" > /dev/null 2>&1
matlab -nosplash -nodisplay -r "plotMegaplot( 'configWholeEruption.m'); quit" > /dev/null 2>&1
