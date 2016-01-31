function idw = lookup_idw(tech, type, L, gmid)

if type == 'n'
   idw = lookup(L, tech.Lvector, gmid, tech.ngmid, tech.nidw);
else   
   idw = lookup(L, tech.Lvector, gmid, tech.pgmid, tech.pidw);
end   

return
