local kernel = {}
kernel.name = "tickShader"
kernel.language = "glsl"
kernel.category = "filter"

kernel.graph =
{
   nodes = {
      horizontal = { effect="filter.blurHorizontal", input1="paint1" },
      vertical = { effect="filter.blurVertical", input1="horizontal" },
   },
   output = "vertical",
}


return kernel