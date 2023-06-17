Raycast = {

    DegToRad = function(deg)
        return (deg * math.pi) / 180.0
    end,

    RotationToDirection = function(rotation)
        local z = Raycast.DegToRad(rotation.z)
        local x = Raycast.DegToRad(rotation.x)
        local multiplier = math.abs(math.cos(x))
        return vector3(-math.sin(z) * multiplier, math.cos(z) * multiplier, math.sin(x))
    end,

    WorldToScreen = function(position)
        local retval, screenX, screenY = GetScreenCoordFromWorldCoord(position.x, position.y, position.z)
        return vector3((screenX - 0.5) * 2, (screenY - 0.5) * 2, 0)
    end,

    ScreenToWorld = function(camPos, relX, relY)
        local camRot = GetGameplayCamRot(0)
        local camForward = Raycast.RotationToDirection(camRot)
        local rotUp = vector3(camRot.x + 10.0, camRot.y, camRot.z)
        local rotDown = vector3(camRot.x - 10.0, camRot.y, camRot.z)
        local rotLeft = vector3(camRot.x, camRot.y, camRot.z - 10.0)
        local rotRight = vector3(camRot.x, camRot.y, camRot.z + 10.0)
        local rR = Raycast.RotationToDirection(rotRight)
        local rL = Raycast.RotationToDirection(rotLeft)
        local rU = Raycast.RotationToDirection(rotUp)
        local rD = Raycast.RotationToDirection(rotDown)
        local camRight = vector3(rR.x - rL.x, rR.y - rL.y, rR.z - rL.z)
        local camUp = vector3(rU.x - rD.x, rU.y - rD.y, rU.z - rD.z)
        local rollRad = -Raycast.DegToRad(camRot.y)
        local cosR = vector3(camRight.x * math.cos(rollRad), camRight.y * math.cos(rollRad), camRight.z * math.cos(rollRad))
        local sinU = vector3(camUp.x * math.sin(rollRad), camUp.y * math.sin(rollRad), camUp.z * math.sin(rollRad))
        local sinR = vector3(camRight.x * math.sin(rollRad), camRight.y * math.sin(rollRad), camRight.z * math.sin(rollRad))
        local cosU = vector3(camUp.x * math.cos(rollRad), camUp.y * math.cos(rollRad), camUp.z * math.cos(rollRad))
        local camRightRoll = vector3(cosR.x - sinU.x, cosR.y - sinU.y, cosR.z - sinU.z)
        local camUpRoll = vector3(sinR.x + cosU.x, sinR.y + cosU.y, sinR.z + cosU.z)
        local tP = vector3(camPos.x + (camForward.x * 10.0), camPos.y + (camForward.y * 10.0), camPos.z + (camForward.z * 10.0))
        local tR = vector3(tP.x + camRightRoll.x, tP.y + camRightRoll.y, tP.z + camRightRoll.z)
        local point3D = vector3(tR.x + camUpRoll.x, tR.y + camUpRoll.y, tR.z + camUpRoll.z)
        local point2D = Raycast.WorldToScreen(point3D)
        if not point2D then return vector3(camPos.x + (camForward.x * 10.0), camPos.y + (camForward.y * 10.0), camPos.z + (camForward.z * 10.0)) end
        local point3DZero = vector3(camPos.x + (camForward.x * 10.0), camPos.y + (camForward.y * 10.0), camPos.z + (camForward.z * 10.0))
        local point2DZero = Raycast.WorldToScreen(point3DZero)
        if not point2DZero then return vector3(camPos.x + (camForward.x * 10.0), camPos.y + (camForward.y * 10.0), camPos.z + (camForward.z * 10.0)) end
        if math.abs(point2D.x - point2DZero.x) < 0.001 or math.abs(point2D.y - point2DZero.y) < 0.001 then return vector3(camPos.x + (camForward.x * 10.0), camPos.y + (camForward.y * 10.0), camPos.z + (camForward.z * 10.0)) end
        local scaleX = (relX - point2DZero.x) / (point2D.x - point2DZero.x)
        local scaleY = (relY - point2DZero.y) / (point2D.y - point2DZero.y)
        local tPF = vector3(camPos.x + (camForward.x * 10.0), camPos.y + (camForward.y * 10.0), camPos.z + (camForward.z * 10.0))
        local tPD = vector3(tPF.x + (camRightRoll.x * scaleX), tPF.y + (camRightRoll.y * scaleX), tPF.z + (camRightRoll.z * scaleX))
        local point3Dret = vector3(tPD.x + (camUpRoll.x * scaleY), tPD.y + (camUpRoll.y * scaleY), tPD.z + (camUpRoll.z * scaleY))
        return point3Dret
    end,

    ProcessCoordinates = function(x, y)
        local screenX, screenY = GetActiveScreenResolution()
        local relativeX = 1 - (x / screenX) * 1.0 * 2
        local relativeY = 1 - (y / screenY) * 1.0 * 2
        if relativeX > 0.0 then relativeX = -relativeX else relativeX = math.abs(relativeX) end
        if relativeY > 0.0 then relativeY = -relativeY else relativeY = math.abs(relativeY) end
        return vector2(relativeX, relativeY)
    end,

    Start = function()
        local x, y = GetNuiCursorPosition()
        local camPos = GetGameplayCamCoord()
        local processedCoords = Raycast.ProcessCoordinates(x, y)
        local target = Raycast.ScreenToWorld(camPos, processedCoords.x, processedCoords.y)
        local dir = vector3(target.x - camPos.x, target.y - camPos.y, target.z - camPos.z)
        local from = vector3(camPos.x + (dir.x * 0.05), camPos.y + (dir.y * 0.05), camPos.z + (dir.z * 0.05))
        local to = vector3(camPos.x + (dir.x * 300), camPos.y + (dir.y * 300), camPos.z + (dir.z * 300))
        local rayHandle = StartShapeTestRay(from.x, from.y, from.z, to.x, to.y, to.z, 30, 0, 0)
        local retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
        return retval, hit, endCoords, surfaceNormal, entityHit
    end

}