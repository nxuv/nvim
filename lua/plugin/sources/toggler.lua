return {
    {
        "nat-418/boole.nvim",
        opts = {
            mappings = {
                increment = '<C-a>',
                decrement = '<C-x>'
            },
            -- User defined loops
            additions = {
                -- OPERATIONS
                { '++',       '--' },
                { '+',        '-' },
                { '<',        '>' },
                { '<=',       '>=' },
                { '&&',       '||' },
                -- MISC
                { '[ ]',      '[x]' },
                { '""',       "''" },
                -- VISIBILITY
                { 'public',   'private' },
                -- TYPES
                { 'struct',   'class' },
                { 'float',    'double' },
                -- COLORS
                { 'white',    'black' },
                -- CSS
                { 'always',   'never' },
                { 'top',      'bottom' },
                { 'left',     'right' },
                { 'up',       'down' },
                { 'relative', 'absolute' },
                { 'width',    'height' },
                { 'vertical', 'horizontal' },
                { 'show',     'hide' },
                { 'outset',   'inset' },
                { 'row',      'column' },
                { 'start',    'end' },
                { 'after',    'before' },
                { 'above',    'below' },
            },
            allow_caps_additions = {
                { 'enable', 'disable' }
            }
        },
    }
}
