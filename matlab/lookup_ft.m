function ft = lookup_ft(tech, type, L, gmid)

if type == 'n'
   ft = lookup(L, tech.Lvector, gmid, tech.ngmid, tech.nft);
else   
   ft = lookup(L, tech.Lvector, gmid, tech.pgmid, tech.pft);
end   

return
