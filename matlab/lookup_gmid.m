function gmid = lookup_gmid(tech, type, L, ft)

if type == 'n'
   gmid = lookup(L, tech.Lvector, ft, tech.nft, tech.ngmid);
else   
   gmid = lookup(L, tech.Lvector, ft, tech.pft, tech.pgmid);
end   

return
