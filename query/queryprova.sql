SELECT StoricoAnalogiche.DataMisura, StoricoAnalogiche.Count,  StoricoAnalogiche.Cod7
FROM ( IOTSmartOSS_HistoricDB.dbo.StoricoAnalogiche
INNER JOIN IOTSmartOSS_HistoricDB.dbo.Tab7
ON StoricoAnalogiche.Cod7 = Tab7.ID)
WHERE StoricoAnalogiche.Cod7 IN (SELECT Tab7.ID where StoricoAnalogiche.Cod7 = 199 or StoricoAnalogiche.Cod7 = 173 or StoricoAnalogiche.Cod7= 180 or StoricoAnalogiche.Cod7= 187 or StoricoAnalogiche.Cod7=460 or StoricoAnalogiche.Cod7=424 or StoricoAnalogiche.Cod7=464 or StoricoAnalogiche.Cod7=465 or StoricoAnalogiche.Cod7= 186 or StoricoAnalogiche.Cod7= 185 or StoricoAnalogiche.Cod7= 184)
and StoricoAnalogiche.Tag like ('%.1021.%') and StoricoAnalogiche.DataMisura > '2021-05-01 01:00:00.000' and StoricoAnalogiche.diag=0 and StoricoAnalogiche.severita >4

UNION

SELECT StoricoDigitali.DataEvento AS DataMisura, StoricoDigitali.Stato AS Count,  StoricoDigitali.Cod7

FROM ( IOTSmartOSS_HistoricDB.dbo.StoricoDigitali
INNER JOIN IOTSmartOSS_HistoricDB.dbo.Tab7
ON StoricoDigitali.Cod7 = Tab7.ID)
WHERE StoricoDigitali.Cod7 IN (SELECT Tab7.ID where StoricoDigitali.Cod7 = 482)
and StoricoDigitali.Tag like ('%.1021.%') and StoricoDigitali.DataEvento > '2021-05-01 01:00:00.000' and StoricoDigitali.diag=0 and StoricoDigitali.severita >4

ORDER BY StoricoAnalogiche.DataMisura ASC