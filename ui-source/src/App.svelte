<script>

    import jquery from 'jquery';

    let OffsetX = null;
    let OffsetY = null;

    let ShowInteraction = false;
    let InteractionData = null;

    let SubMenuCount = 0;
    let ActiveSubMenus = [ ];
    let ActiveSubSubMenus = [ ];

    let CanOpenSubMenu = true;

    jquery(document).ready(function() {
        window.addEventListener('message', event => {
            switch (event.data.type) {
                case 'ShowInteraction':
                    ShowInteraction = true;
                    InteractionData = event.data.data;
                    break;
                case 'HideInteraction':
                    ShowInteraction = false;
                    InteractionData = null;
                    CanOpenSubMenu = true;
                    ActiveSubMenus = [ ];
                    ActiveSubSubMenus = [ ];
                    SubMenuCount = 0;
                    break;
            }
        });
        jquery('.wrapper').on('contextmenu', function(event) {
            jquery['post']('https://3core-interaction/startInteraction', JSON.stringify({}));
            OffsetX = event.offsetX;
            OffsetY = event.offsetY;
            ShowInteraction = false;
            CanOpenSubMenu = true;
            ActiveSubMenus = [ ];
            ActiveSubSubMenus = [ ];
            SubMenuCount = 0;
        });
    });

    function OpenSubMenu(data, id) {
        if (!data['SubMenu']) return;
        SubMenuCount++;
        let marginLeft = (10.2 * SubMenuCount);
        let marginTop = (2.8 * SubMenuCount);
        jquery('#main').append(`<div class="interaction" id="submenu-`+id+`" style="margin-left: `+marginLeft+`vw; margin-top: `+marginTop+`vh;"></div>`);
        data['SubMenu'].forEach((element, index) => {
            if (element['Title'] != undefined) {
                if (!element['SubMenu']) {
                    if (element['Image']) {
                        jquery('#'+'submenu-'+id).append(`
                            <div class="item" id="item-`+(id + index)+`">
                                <img alt="" src="`+element['Image']+`">
                                <div class="text">
                                    <h1>`+element['Title']+`</h1>
                                    <span>`+element['SubTitle']+`</span>
                                </div>
                            </div>
                        `);
                        if (element['OnClick']) {
                            jquery('#item-' + (id + index)).addClass('hover');
                            jquery('#item-' + (id + index)).on('click', function() {
                                jquery['post']('https://3core-interaction/onClick', JSON.stringify({
                                    item: element
                                }));
                            });
                        }
                    } else {
                        jquery('#'+'submenu-'+id).append(`
                            <div class="item" id="item-`+(id + index)+`">
                                <div class="text">
                                    <h1>`+element['Title']+`</h1>
                                    <span>`+element['SubTitle']+`</span>
                                </div>
                            </div>
                        `);
                        if (element['OnClick']) {
                            jquery('#item-' + (id + index)).addClass('hover');
                            jquery('#item-' + (id + index)).on('click', function() {
                                jquery['post']('https://3core-interaction/onClick', JSON.stringify({
                                    item: element
                                }));
                            });
                        }
                    }
                } else {
                    if (element['Image']) {
                        jquery('#'+'submenu-'+id).append(`
                            <div class="item hover" id="item-`+(id + index)+`">
                                <img alt="" src="`+element['Image']+`">
                                <div class="text">
                                    <h1>`+element['Title']+`</h1>
                                    <span>`+element['SubTitle']+`</span>
                                </div>
                                <img alt="" src="https://cdn.discordapp.com/attachments/928768829675429938/1119553279026790411/fast-forward-double-right-arrows-symbol.png">
                            </div>
                        `);
                    } else {
                        jquery('#'+'submenu-'+id).append(`
                            <div class="item hover" id="item-`+(id + index)+`">
                                <div class="text">
                                    <h1>`+element['Title']+`</h1>
                                    <span>`+element['SubTitle']+`</span>
                                </div>
                                <img alt="" src="https://cdn.discordapp.com/attachments/928768829675429938/1119553279026790411/fast-forward-double-right-arrows-symbol.png">
                            </div>
                        `);
                    }
                    jquery('#item-' + (id + index)).on('click', function() {
                        if (ActiveSubSubMenus[id + index]) {
                            jquery('#'+'submenu-'+(id + index)).remove();
                            ActiveSubSubMenus[id + index] = false;
                            SubMenuCount--;
                            jquery('#item-'+(id + index)+' img:last-child').removeClass('active');
                        } else {
                            OpenSubMenu(element, (id + index));
                            ActiveSubSubMenus[id + index] = true;
                            jquery('#item-'+(id + index)+' img:last-child').addClass('active');
                        }
                    });
                }
            }
        });
    }

    function GenerateSubMenu(data, id) {
        if (!data['SubMenu']) {
            jquery['post']('https://3core-interaction/onClick', JSON.stringify({
                item: data
            }));
        } else {
            if (ActiveSubMenus[id]) {
                ActiveSubMenus.forEach((val, index) => {
                    jquery('#'+'submenu-'+index).remove();
                });
                ActiveSubSubMenus.forEach((val, index) => {
                    jquery('#'+'submenu-'+index).remove();
                });
                ActiveSubMenus = [ ];
                ActiveSubSubMenus = [ ];
                SubMenuCount = 0;
                CanOpenSubMenu = true;
            } else {
                if (!CanOpenSubMenu) return;
                OpenSubMenu(data, id);
                ActiveSubMenus[id] = true;
                CanOpenSubMenu = false;
            }
        }
    }
    
</script>

<div class="wrapper">
    {#if ShowInteraction}
        <div class="interaction" id="main" style="top: {OffsetY}px; left: {OffsetX}px">
            {#each InteractionData as Item, Index}
                {#if Item['Title'] != undefined}
                    <div class={ Item['SubMenu'] || Item['OnClick'] ? 'item hover' : 'item' } on:mousedown={() => GenerateSubMenu(Item, Index)}>
                        {#if Item['Image']}
                            <img alt="" src={Item['Image']}>
                        {/if}
                        <div class="text">
                            {#if Item['Title']}
                                <h1>{Item['Title']}</h1>
                            {/if}
                            {#if Item['SubTitle']}
                                <span>{Item['SubTitle']}</span>
                            {/if}
                        </div>
                        {#if Item['SubMenu']}
                            <img alt="" src="https://cdn.discordapp.com/attachments/928768829675429938/1119553279026790411/fast-forward-double-right-arrows-symbol.png" class={ActiveSubMenus[Index] ? 'active' : ''}>
                        {/if}
                    </div>
                {/if}
            {/each}
        </div>
    {/if}
</div>