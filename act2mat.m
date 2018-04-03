function act = act2mat(proj_meta, site, tp)

act = vertcat(proj_meta(site).rd(1:4,tp).act);