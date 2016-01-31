function L = lookup_minL(tech, type, gmId, gmgds)

    for k = 1:length(tech.Lvector)
        L = tech.Lvector(k);
        retVal = lookup_gmro(tech, type, L, gmId);
        
        if(retVal > gmgds)
            return
        end
    end
 
    % Couldn't find an L to meet the requirement
    L = NaN;
return
