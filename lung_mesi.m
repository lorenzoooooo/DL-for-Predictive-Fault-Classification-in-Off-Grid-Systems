function lung = lung_mesi(mese)
switch mese
    case {1,3,5,7,8,10,12}
        lung=31;
    case{4,6,9,11}
        lung=30;
    case 2
        lung=28;
    otherwise
        lung="NaN";
end