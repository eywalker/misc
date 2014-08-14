function runSetPath(exclude)
    if nargin < 1
        exclude = {};
    end
    base = fileparts(mfilename('fullpath'));
    dstruct = dir(base);
    dstruct = dstruct([dstruct.isdir]);
    for sub = dstruct'
        if ismember(sub.name, [{'.', '..'} exclude]) % skip . and .. directory refs
            continue;
        end
        
        subdstruct = dir(sub.name);
        if ismember('setPath.m', {subdstruct.name})
            
            run(fullfile(base, sub.name, 'setPath.m'));
            fprintf('Added project %s to path...\n', sub.name);
%             catch
%                 fprintf('Error encountered while running setPath.m inside subdirectory %s\n', sub.name);
%             end
        end
    end
    
end