function Cdd = lookup_Cgd(tech, type, L, Cgg)

idx1 = max(find(tech.Lvector <= L));
idx2 = min(find(tech.Lvector >= L));

if type == 'n'
    if(idx1 == idx2)
        Cdd = tech.ncdd_cgg(idx1) * Cgg;
    else
        Cdd = interp1( [tech.Lvector(idx1) tech.Lvector(idx2)], ...
                       [tech.ncdd_cgg(idx1) tech.ncdd_cgg(idx2)], L) * Cgg;       
    end
else
    if(idx1 == idx2)
        Cdd = tech.pcdd_cgg(idx1) * Cgg;
    else
        Cdd = interp1( [tech.Lvector(idx1) tech.Lvector(idx2)], ...
                       [tech.pcdd_cgg(idx1) tech.pcdd_cgg(idx2)], L) * Cgg;    
    end
end   
return
