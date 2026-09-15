-- Montior wiki https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output    = "eDP-1",
    mode      = "preferred",
    position  = "0x0",
    scale     = 1.00,
})

hl.monitor({
    output   = "DP-1",
    mode     = "1920x1080@75",
    position = "0x-1080",
    scale    = 1.00,
})

hl.workspace_rule({
    workspace = "1",
    monitor = "eDP-1",
    default = true,
})

hl.workspace_rule({
    workspace = "2",
    monitor = "DP-1",
    default = true,
})
