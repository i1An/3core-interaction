**Cool script I found lying around in my old server files.**
\
**It's using the mouse position to interact with the 3D world.**

**The script supports 5 different interaction types:**
* **Entity Bone** - interact with the bones of any entity. eg - open / close the vehicle left / right door.
* **Ped Bone** - interact with the bones of any player. eg - move the left / right hand.
* **Prop** - interact with every game prop. eg - store cash register.
* **Entity** - interact with every game entity. eg - created ped.
* **Player** - interact with every player in the server. eg - cuff / uncuff for police officers.

**To get mouse focus for the interaction, press Left ALT (this keybind can be changed ingame: SETTINGS > Key Bindings > FiveM > Open Interaction Mouse).**

``Examples for every option can be found in the example.lua file.``

# Available Exports
* [AddEntityBone](#AddEntityBone)
* [AddPedBone](#AddPedBone)
* [AddProp](#AddProp)
* [AddEntity](#AddEntity)
* [GetLastEntity](#GetLastEntity)
# ``AddEntityBone``
```perl
exports['3core-interaction']:AddEntityBone({
    # Bone names can be found here: https://docs.fivem.net/natives/?_0xFB71170B7E76ACBA
    Bone = 'door_dside_f',
    Options = {
        {
            # Menu item icon (optional)
            Image = '',
            # Menu item title (optional)
            Title = 'Police',
            # Menu item subtitle (optional)
            SubTitle = 'Search, cuff, escort, etc..',
            # Condition check. If true was returned, the item will be shown. eg - job check.
            CanShow = function()
                return true
            end,
            # Will be triggered when the player clicked on the item.
            OnClick = {
                # client-event, server-event, command.
                Type = '',
                # Event / command name.
                Value = '',
                # Close the menu when clicked.
                Close = true 
            }
            # If you want the item to open another interaction menu, leave this and remove OnClick.
            # Submenus behave like a normal interact menu so all the above values are the same for the submenus. 
            SubMenu = {
                {
                    # Menu item icon (optional)
                    Image = '',
                    # Menu item title (optional)
                    Title = 'Police',
                    # Menu item subtitle (optional)
                    SubTitle = 'Search, cuff, escort, etc..',
                    # Condition check. If true was returned, the item will be shown. eg - job check.
                    CanShow = function()
                        return true
                    end,
                    # Will be triggered when the player clicked on the item.
                    OnClick = {
                        # client-event, server-event, command.
                        Type = '',
                        # Event / command name.
                        Value = '',
                        # Close the menu when clicked.
                        Close = true 
                    }
                }
            }
        }
    }
})
```
# ``AddPedBone``
```perl
exports['3core-interaction']:AddPedBone({
    # Bone ids can be found here: https://docs.fivem.net/natives/?_0xFB71170B7E76ACBA
    Bone = 0xDEAD,
    Options = {
        {
            # Menu item icon (optional)
            Image = '',
            # Menu item title (optional)
            Title = 'Police',
            # Menu item subtitle (optional)
            SubTitle = 'Search, cuff, escort, etc..',
            # Condition check. If true was returned, the item will be shown. eg - job check.
            CanShow = function()
                return true
            end,
            # Will be triggered when the player clicked on the item.
            OnClick = {
                # client-event, server-event, command.
                Type = '',
                # Event / command name.
                Value = '',
                # Close the menu when clicked.
                Close = true 
            }
            # If you want the item to open another interaction menu, leave this and remove OnClick.
            # Submenus behave like a normal interact menu so all the above values are the same for the submenus. 
            SubMenu = {
                {
                    # Menu item icon (optional)
                    Image = '',
                    # Menu item title (optional)
                    Title = 'Police',
                    # Menu item subtitle (optional)
                    SubTitle = 'Search, cuff, escort, etc..',
                    # Condition check. If true was returned, the item will be shown. eg - job check.
                    CanShow = function()
                        return true
                    end,
                    # Will be triggered when the player clicked on the item.
                    OnClick = {
                        # client-event, server-event, command.
                        Type = '',
                        # Event / command name.
                        Value = '',
                        # Close the menu when clicked.
                        Close = true 
                    }
                }
            }
        }
    }
})
```
# ``AddProp``
```perl
exports['3core-interaction']:AddProp({
    # All game props can be found here: https://forge.plebmasters.de/objects
    Prop = 'prop_till_01',
    Options = {
        {
            # Menu item icon (optional)
            Image = '',
            # Menu item title (optional)
            Title = 'Police',
            # Menu item subtitle (optional)
            SubTitle = 'Search, cuff, escort, etc..',
            # Condition check. If true was returned, the item will be shown. eg - job check.
            CanShow = function()
                return true
            end,
            # Will be triggered when the player clicked on the item.
            OnClick = {
                # client-event, server-event, command.
                Type = '',
                # Event / command name.
                Value = '',
                # Close the menu when clicked.
                Close = true 
            }
            # If you want the item to open another interaction menu, leave this and remove OnClick.
            # Submenus behave like a normal interact menu so all the above values are the same for the submenus. 
            SubMenu = {
                {
                    # Menu item icon (optional)
                    Image = '',
                    # Menu item title (optional)
                    Title = 'Police',
                    # Menu item subtitle (optional)
                    SubTitle = 'Search, cuff, escort, etc..',
                    # Condition check. If true was returned, the item will be shown. eg - job check.
                    CanShow = function()
                        return true
                    end,
                    # Will be triggered when the player clicked on the item.
                    OnClick = {
                        # client-event, server-event, command.
                        Type = '',
                        # Event / command name.
                        Value = '',
                        # Close the menu when clicked.
                        Close = true 
                    }
                }
            }
        }
    }
})
```
# ``AddEntity``
```perl
exports['3core-interaction']:AddEntity({
    # Valid entity handle
    Entity = 123,
    Options = {
        {
            # Menu item icon (optional)
            Image = '',
            # Menu item title (optional)
            Title = 'Police',
            # Menu item subtitle (optional)
            SubTitle = 'Search, cuff, escort, etc..',
            # Condition check. If true was returned, the item will be shown. eg - job check.
            CanShow = function()
                return true
            end,
            # Will be triggered when the player clicked on the item.
            OnClick = {
                # client-event, server-event, command.
                Type = '',
                # Event / command name.
                Value = '',
                # Close the menu when clicked.
                Close = true 
            }
            # If you want the item to open another interaction menu, leave this and remove OnClick.
            # Submenus behave like a normal interact menu so all the above values are the same for the submenus. 
            SubMenu = {
                {
                    # Menu item icon (optional)
                    Image = '',
                    # Menu item title (optional)
                    Title = 'Police',
                    # Menu item subtitle (optional)
                    SubTitle = 'Search, cuff, escort, etc..',
                    # Condition check. If true was returned, the item will be shown. eg - job check.
                    CanShow = function()
                        return true
                    end,
                    # Will be triggered when the player clicked on the item.
                    OnClick = {
                        # client-event, server-event, command.
                        Type = '',
                        # Event / command name.
                        Value = '',
                        # Close the menu when clicked.
                        Close = true 
                    }
                }
            }
        }
    }
})
```
# ``GetLastEntity``
```perl
# returns the last entity the player interacted with.
local entity = exports['3core-interaction']:GetLastEntity()
```
# UI Build
* UI css can be found in > ui-source/src/App.css
* UI html / js can be found in > ui-source/src/App.svelte
* Make sure you have node.js installed. https://nodejs.org/en
* Open the cmd in the ui-source directory
* Run npm i
* Run npm run build
