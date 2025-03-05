local colors = {
	black = "#1b1d2b",
	white = "#828bb8",
	red = "#ff757f",
	green = "#c3e88d",
	blue = "#82aaff",
	yellow = "#ffc777",
	orange = "#ff966c",
	magenta = "#c099ff",
	grey = "#c8d3f5",
}

return {
	black = 0xff181819, -- #1b1d2b
	white = 0xffe2e2e3, -- #828bb8
	red = 0xfffc5d7c, -- #ff757f
	green = 0xff9ed072, -- #c3e88d
	blue = 0xff76cce0, -- #82aaff
	yellow = 0xffe7c664, -- #ffc777
	orange = 0xfff39660, -- #ff966c
	magenta = 0xffb39df3, -- #c099ff
	grey = 0xff7f8490, -- #c8d3f5
	transparent = 0x00000000,

	bar = {
		bg = 0xf02c2e34, -- #222436
		border = 0xff2c2e34, -- #1b1d2b
	},
	popup = {
		bg = 0xf02c2e34, -- #222436
		border = 0xff2c2e34, -- #1b1d2b
	},
	bg1 = 0xff363944,
	bg2 = 0xff414550,

	with_alpha = function(color, alpha)
		if alpha > 1.0 or alpha < 0.0 then
			return color
		end
		return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	end,
}
