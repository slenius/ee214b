function vgs = lookup_vgs(tech, type, L, gmid)

if type == 'n'
   vgs = lookup(L, tech.Lvector, gmid, tech.ngmid, tech.vgs);
else   
   vgs = lookup(L, tech.Lvector, gmid, tech.pgmid, tech.vgs);
end   

return
