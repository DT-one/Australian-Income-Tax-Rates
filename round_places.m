function out = round_places(x,places)

  if ~exist('places','var')
    places = 0;
  end

  if numel(places) > 1
    error('places should be a single number');
  end

  out = round(x.*10^places)/10.^places;

end
