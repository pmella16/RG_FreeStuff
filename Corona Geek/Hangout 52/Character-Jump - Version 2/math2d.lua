-- =============================================================
-- Copyright Roaming Gamer, LLC. 2009-2013 
-- =============================================================
-- 2D Math Library (for operating on display objects)
-- =============================================================
-- Short and Sweet License: 
-- 1. You may use anything you find in the SSKCorona library and sampler to make apps and games for free or $$.
-- 2. You may not sell or distribute SSKCorona or the sampler as your own work.
-- 3. If you intend to use the art or external code assets, you must read and follow the licenses found in the
--    various associated readMe.txt files near those assets.
--
-- Credit?:  Mentioning SSKCorona and/or Roaming Gamer, LLC. in your credits is not required, but it would be nice.  Thanks!
--
-- =============================================================
-- Docs: https://github.com/roaminggamer/SSKCorona/wiki
-- =============================================================

--[[  All standard math functions
math.abs   math.acos  math.asin  math.atan math.atan2 math.ceil
math.cos   math.cosh  math.deg   math.exp  math.floor math.fmod
math.frexp math.huge  math.ldexp math.log  math.log10 math.max
math.min   math.modf  math.pi    math.pow  math.rad   math.random
math.randomseed       math.sin   math.sinh math.sqrt  math.tanh
math.tan
--]]

-- Localizing math functions for speedup!
local mDeg  = math.deg
local mRad  = math.rad
local mCos  = math.cos
local mSin  = math.sin
local mAcos = math.acos
local mAsin = math.asin
local mSqrt = math.sqrt
local mCeil = math.ceil
local mFloor = math.floor
local mAtan2 = math.atan2
local mPi = math.pi

local math2do = {}

-- ==
--    math2d.add( ... [ , altRet ]) - Calculates the sum of two vectors: <x1, y1> + <x2, y2> == <x1 + x2 , y1 + y2>
-- ==
function math2do.add( ... ) -- ( objA, objB [, altRet] ) or ( x1, y1, x2, y2, [, altRet]  )
	if( type(arg[1]) == "number" ) then
		local x,y = arg[1] + arg[3], arg[2] + arg[4]

		if(arg[5]) then
			return { x=x, y=y }
		else
			return x,y
		end
	else
		local x,y = arg[1].x + arg[2].x, arg[1].y + arg[2].y
			
		if(arg[3]) then
			return x,y
		else
			return { x=x, y=y }
		end
	end
end

-- ==
--    math2d.sub( ... [ , altRet ]) - Calculates the difference of two vectors: <x2, y2> + <x1, y1> == <x2 - x1 , y2 - y1>
-- ==
function math2do.sub( ... ) -- ( objA, objB [, altRet] ) or ( x1, y1, x2, y2, [, altRet]  )
	if( type(arg[1]) == "number" ) then
		local x,y = arg[3] - arg[1], arg[4] - arg[2]

		if(arg[5]) then
			return { x=x, y=y }
		else
			return x,y
		end
	else
		local x,y = arg[2].x - arg[1].x, arg[2].y - arg[1].y
			
		if(arg[3]) then
			return x,y
		else
			return { x=x, y=y }
		end
	end
end

-- ==
--    math2d.dot( ... ) - Calculates the dot (inner) product of two vectors: <x1, y1> . <x2, y2> == x1 * x2 + y1 * y2
-- ==
function math2do.dot( ... ) -- ( objA, objB ) or ( x1, y1, x2, y2 )
	local retVal = 0
	if( type(arg[1]) == "number" ) then
		retVal = arg[1] * arg[3] + arg[2] * arg[4]
	else
		retVal = arg[1].x * arg[2].x + arg[1].y * arg[2].y
	end

	return retVal
end

-- ==
--    math2d.length( ... ) - Calculates the length of vector <x1, y1> == math.sqrt( x1 * x1 + y1 * y1 )
-- ==
function math2do.length( ... ) -- ( objA ) or ( x1, y1 )
	local len
	if( type(arg[1]) == "number" ) then
		len = mSqrt(arg[1] * arg[1] + arg[2] * arg[2])
	else
		len = mSqrt(arg[1].x * arg[1].x + arg[1].y * arg[1].y)
	end
	return len
end

-- ==
--    math2d.squarelength( ... ) - Calculates the squared length of vector <x1, y1> == x1 * x1 + y1 * y1
-- ==
function math2do.squarelength( ... ) -- ( objA ) or ( x1, y1 )
	local squareLen
	if( type(arg[1]) == "number" ) then
		squareLen = arg[1] * arg[1] + arg[2] * arg[2]
	else
		squareLen = arg[1].x * arg[1].x + arg[1].y * arg[1].y
	end
	return squareLen
end

-- ==
--    math2d.scale( ..., scale [ , altRet ]) - Calculates a scaled vector scale * <x1, y1> = <scale * x1, scale * y1>
-- ==
function math2do.scale( ... ) -- ( objA, scale [, altRet] ) or ( x1, y1, scale, [, altRet]  )
	if( type(arg[1]) == "number" ) then
		local x,y = arg[1] * arg[3], arg[2] * arg[3]

		if(arg[4]) then
			return { x=x, y=y }
		else
			return x,y
		end
	else
		local x,y = arg[1].x * arg[2], arg[1].y * arg[2]
			
		if(arg[3]) then
			return x,y
		else
			return { x=x, y=y }
		end
	end
end

-- ==
--    math2d.normalize( ... [ , altRet ]) - Calculates the normalized (unit length) version of a vector.  A normalized vector has a length of 1.
-- ==
function math2do.normalize( ... ) -- ( objA [, altRet] ) or ( x1, y1 [, altRet]  )
	if( type(arg[1]) == "number" ) then
		local len = math2do.length( arg[1], arg[2], false )
		local x,y = arg[1]/len,arg[2]/len

		if(arg[3]) then
			return { x=x, y=y }
		else
			return x,y
		end
	else
		local len = math2do.length( arg[1], arg[2], true )
		local x,y = arg[1].x/len,arg[1].y/len
			
		if(arg[2]) then
			return x,y
		else
			return { x=x, y=y }
		end
	end
end

-- ==
--    d math2d.normals( ... [ , altRet ]) - Returns the two normal vectors for a vector. (Every vector has two normal vectors. i.e. Vectors at 90-degree angles to the original vector.)
--
--    Warning: These normal vectors are not normalized and may need more processing to be useful in other calculations.
-- ==
function math2do.normals( ... ) -- ( objA [, altRet] ) or ( x1, y1 [, altRet]  )
	if( type(arg[1]) == "number" ) then
		local nx1,ny1,nx2,ny2 = -arg[1], arg[2], arg[1], -arg[2]

		if(arg[3]) then
			return { x=nx1, y=ny1 }, { x=nx2, y=ny2 }
		else
			return nx1,ny1,nx2,ny2
		end
	else
		local nx1,ny1,nx2,ny2 = -arg[1].x, arg[1].y, arg[1].x, -arg[1].y
			
		if(arg[2]) then
			return nx1,ny1,nx2,ny2			
		else
			return { x=nx1, y=ny1 }, { x=nx2, y=ny2 }
		end
	end
end

-- ==
--    math2d.vector2Angle( ... ) - Converts a screen-space vector to a display object angle (rotation).
-- ==
function math2do.vector2Angle( ... ) -- ( objA ) or ( x1, y1 )
	local angle
	if( type(arg[1]) == "number" ) then
		angle = mCeil(mAtan2( (arg[2]), (arg[1]) ) * 180 / mPi) + 90
	else
		angle = mCeil(mAtan2( (arg[1].y), (arg[1].x) ) * 180 / mPi) + 90
	end
	return angle
end

-- ==
--    math2d.angle2Vector( angle [ , altRet ]) - Converts a display object angle (rotation) into a screen-space vector.
-- ==
function math2do.angle2Vector( angle, tableRet )
	local screenAngle = mRad(-(angle+90))
	local x = mCos(screenAngle) 
	local y = mSin(screenAngle) 

	if(tableRet == true) then
		return { x=-x, y=y }
	else
		return -x,y
	end
end

-- ==
--    math2d.cartesian2Screen( ... [ , altRet ]) - Converts cartesian coordinates to the equivalent screen coordinates.
-- ==
function math2do.cartesian2Screen( ... ) -- ( objA [, altRet] ) or ( x1, y1 [, altRet]  )
	if( type(arg[1]) == "number" ) then
		if(arg[3]) then
			return { x=arg[1], y=-arg[2] }
		else
			return arg[1],-arg[2]
		end
	else
		if(arg[2]) then
			return arg[1].x,-arg[1].y
		else
			return { x=arg[1].x, y=-arg[1].y }
		end
	end
end

-- ==
--    math2d.screen2Cartesian( ... [ , altRet ]) - Converts screen coordinates to the equivalent cartesian coordinates.
-- ==
function math2do.screen2Cartesian( ... ) -- ( objA [, altRet] ) or ( x1, y1 [, altRet]  )
	if( type(arg[1]) == "number" ) then
		if(arg[3]) then
			return { x=arg[1], y=-arg[2] }
		else
			return arg[1],-arg[2]
		end
	else
		if(arg[2]) then
			return arg[1].x,-arg[1].y
		else
			return { x=arg[1].x, y=-arg[1].y }
		end
	end
end


return math2do