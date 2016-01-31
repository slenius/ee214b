function Cgd = lookup_Cgd(tech, type, L, Cgg)

idx1 = max(find(tech.Lvector <= L));
idx2 = min(find(tech.Lvector >= L));

if type == 'n'
     if(idx1 == idx2)
        Cgd = tech.ncgd_cgg(idx1) * Cgg;
    else
        Cgd = interp1( [tech.Lvector(idx1) tech.Lvector(idx2)], ...
                       [tech.ncgd_cgg(idx1) tech.ncgd_cgg(idx2)], L) * Cgg;       
     end
else   
     if(idx1 == idx2)
        Cgd = tech.pcgd_cgg(idx1) * Cgg;
    else
        Cgd = interp1( [tech.Lvector(idx1) tech.Lvector(idx2)], ...
                       [tech.pcgd_cgg(idx1) tech.pcgd_cgg(idx2)], L) * Cgg;    
     end
end   

return
