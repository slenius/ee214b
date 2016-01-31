function gmro = lookup_gmro(tech, type, L, gmid)

if type == 'n'
   gmro = lookup(L, tech.Lvector, gmid, tech.ngmid, tech.ngmgds);
else   
   gmro = lookup(L, tech.Lvector, gmid, tech.pgmid, tech.pgmgds);
end   

return
