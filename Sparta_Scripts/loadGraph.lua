--required -using relative paths
require "AddAppDirectory"
AddAppDirectory()

runfile[[graph\loadGraphFiles.lua]]

function createAndReturnGraphVisualization(a)
	local fact = a.fact or .15
	local radius = a.radius or .03
	local pos = a.pos or {2, 1.75, 0}
	factor = 75
	local edgeColor = {(factor / 255), (factor / 255), (factor / 255), 1}
	local g = Graph(
		{
			-- y = 0
			["012345678"] = GraphNode{position = {0, 0, 0}, radius = radius};
			-- y = -1
			["12345678"] = GraphNode{position = {0, -1 * fact, 0}, radius = radius, color = colorTable.Es};
			-- y = -2
			["2345678"] = GraphNode{position = {-.5 * fact, -2 * fact, 0}, radius = radius, color = colorTable.E};
			["1235678"] = GraphNode{position = {.5 * fact, -2 * fact, 0}, radius = radius, color = colorTable.R};
			-- y = -3
			["234678"] = GraphNode{position = {-1.5 * fact, -3 * fact, 0}, radius = radius, color = colorTable.S};
			["245678"] = GraphNode{position = {-.5 * fact, -3 * fact, 0}, radius = radius, color = colorTable.K};
			["235678"] = GraphNode{position = {.5 * fact, -3 * fact, 0}, radius = radius, color = colorTable.E};
			["123578"] = GraphNode{position = {1.5 * fact, -3 * fact, 0}, radius = radius, color = colorTable.Sh};
			-- y = -4
			["24678"] = GraphNode{position = {-1.5 * fact, -4 * fact, 0}, radius = radius, color = colorTable.K};
			["23678"] = GraphNode{position = {-.5 * fact, -4 * fact, 0}, radius = radius, color = colorTable.R};
			["25678"] = GraphNode{position = {.5 * fact, -4 * fact, 0}, radius = radius, color = colorTable.K};
			["23578"] = GraphNode{position = {1.5 * fact, -4 * fact, 0}, radius = radius, color = colorTable.E};
			-- y = -5
			["2678"] = GraphNode{position = {-.5 * fact, -5 * fact, 0}, radius = radius, color = colorTable.R};
			["2378"] = GraphNode{position = {.5 * fact, -5 * fact, 0}, radius = radius, color = colorTable.S};
			["2578"] = GraphNode{position = {1.5 * fact, -5 * fact, 0}, radius = radius, color = colorTable.K};
			-- y = -6
			["278"] = GraphNode{position = {.5 * fact, -6 * fact, 0}, radius = radius, color = colorTable.Sh};
			["258"] = GraphNode{position = {1.5 * fact, -6 * fact, 0}, radius = radius, color = colorTable.Sp};
			-- y = -7
			["28"] = GraphNode{position = {.5 * fact, -7 * fact, 0}, radius = radius, color = colorTable.Sp};
			-- y = -8
			["2"] = GraphNode{position = {.5 * fact, -8 * fact, 0}, radius = radius, color = colorTable.Spi};


		},
		{
			DirectedEdge("012345678", "12345678", {destColor = colorTable.Es, color = edgeColor});--1

			DirectedEdge("12345678", "2345678", {destColor = colorTable.E, color = edgeColor});--2
			DirectedEdge("12345678", "1235678", {destColor = colorTable.R, color = edgeColor});--3

			DirectedEdge("2345678", "234678", {destColor = colorTable.S, color = edgeColor});--4
			DirectedEdge("2345678", "245678", {destColor = colorTable.K, color = edgeColor});--5
			DirectedEdge("2345678", "235678", {destColor = colorTable.R, color = edgeColor});--6
			DirectedEdge("1235678", "235678", {destColor = colorTable.E, color = edgeColor});--7
			DirectedEdge("1235678", "123578", {destColor = colorTable.Sh, color = edgeColor});--8

			DirectedEdge("234678", "24678", {destColor = colorTable.K, color = edgeColor});--9
			DirectedEdge("234678", "23678", {destColor = colorTable.R, color = edgeColor});--10
			DirectedEdge("245678", "24678", {destColor = colorTable.S, color = edgeColor});--11
			DirectedEdge("245678", "25678", {destColor = colorTable.R, color = edgeColor});--12
			DirectedEdge("235678", "23678", {destColor = colorTable.S, color = edgeColor});--13
			DirectedEdge("235678", "25678", {destColor = colorTable.K, color = edgeColor});--14
			DirectedEdge("123578", "23578", {destColor = colorTable.E, color = edgeColor});--15

			DirectedEdge("24678", "2678", {destColor = colorTable.R, color = edgeColor});--16
			DirectedEdge("23678", "2678", {destColor = colorTable.K, color = edgeColor});--17
			DirectedEdge("25678", "2678", {destColor = colorTable.S, color = edgeColor});--18
			--
			DirectedEdge("25678", "2578", {destColor = colorTable.Sh, color = edgeColor});--19
			--
			DirectedEdge("23578", "2378", {destColor = colorTable.S, color = edgeColor});--20
			DirectedEdge("23578", "2578", {destColor = colorTable.K, color = edgeColor});--21

			DirectedEdge("2678", "278", {destColor = colorTable.Sh, color = edgeColor});--22
			DirectedEdge("2378", "278", {destColor = colorTable.K, color = edgeColor});--23
			DirectedEdge("2578", "278", {destColor = colorTable.S, color = edgeColor});--24
			DirectedEdge("2578", "258", {destColor = colorTable.Sp, color = edgeColor});--25

			DirectedEdge("278", "28", {destColor = colorTable.Sp, color = edgeColor});--26
			DirectedEdge("258", "28", {destColor = colorTable.S, color = edgeColor});--27

			DirectedEdge("28", "2", {destColor = colorTable.Spi, color = edgeColor});
		})

	gxform = Transform{
		position = pos,
		g.osg.root,
	}

	return g, gxform
end