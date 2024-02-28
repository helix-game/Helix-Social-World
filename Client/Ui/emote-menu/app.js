// SWITCH CATEGORY
let categories = [ 
    {
        name: "all",
        tab: document.querySelector('.all')
    },
    {
        name: "dance",
        tab: document.querySelector('.dances')
    },
    {
        name: "action",
        tab: document.querySelector('.actions')
    }
]
// PUSH EMOTES
let emotesData = [
    {
        id: 1,
        imageUrl: "images/T_emotes1.svg",
        type: "dance",
        name: "breakdance"
    },
    {
        id: 2,
        imageUrl: "images/T_emotes2.svg",
        type: "action",
        name: "turn left back"
    },
    {
        id: 3,
        imageUrl: "images/T_emotes3.svg",
        type: "dance",
        name: "legwork"
    },
    {
        id: 4,
        imageUrl: "images/T_emotes4.svg",
        type: "dance",
        name: "hoosie slide"
    },
    {
        id: 5,
        imageUrl: "images/T_emotes5.svg",
        type: "action",
        name: "jump up"
    },
    {
        id: 6,
        imageUrl: "images/T_emotes6.svg",
        type: "action",
        name: "super long name"
    },
    {
        id: 7,
        imageUrl: "images/T_emotes7.svg",
        type: "action",
        name: "a bad action"
    },
    {
        id: 8,
        imageUrl: "images/T_emotes8.svg",
        type: "action",
        name: "boss moves"
    },
    {
        id: 9,
        imageUrl: "images/T_emotes9.svg",
        type: "action",
        name: "very very long name emote"
    },
    {
        id: 10,
        imageUrl: "images/T_emotes10.svg",
        type: "action",
        name: "very very long name emote"
    },
    {
        id: 11,
        imageUrl: "images/T_emotes11.svg",
        type: "dance",
        name: "moonwalk"
    },
    {
        id: 12,
        imageUrl: "images/T_emotes12.svg",
        type: "dance",
        name: "very very long name emote"
    },
    {
        id: 13,
        imageUrl: "images/T_emotes13.svg",
        type: "action",
        name: "very very long name emote"
    },
    {
        id: 14,
        imageUrl: "images/T_emotes14.svg",
        type: "dance",
        name: "AHHHHHH"
    },
    {
        id: 15,
        imageUrl: "images/T_emotes15.svg",
        type: "action",
        name: "very very long name emote"
    },
    {
        id: 16,
        imageUrl: "images/T_emotes16.svg",
        type: "dance",
        name: "very very long name emote"
    },
    {
        id: 17,
        imageUrl: "images/T_emotes17.svg",
        type: "action",
        name: "very very long name emote"
    },
    {
        id: 18,
        imageUrl: "images/T_emotes18.svg",
        type: "dance",
        name: "very very long name emote"
    },
]
let selectedEmotes = {}
const pressState = (Id) => {
    document.querySelector(`.emote${Id}`).classList.add('display');
    document.querySelector('.playemote').classList.remove('hidden');
    let data = emotesData.filter(emote => emote.id === Id);
    const {imageUrl, name, type} = data[0];
    document.querySelector('#emotename').innerHTML = name;
    document.querySelector('#emotetype').innerHTML = type;
    document.querySelector('#emoteimg').src = imageUrl;
    if(currentfilter !== 'all'){
        let data = emotesData.filter((emote) => emote.type === currentfilter);
        data.map((emote) => {
            if(emote.id !== Id){
                document.querySelector(`.emote${emote.id}`).classList.remove('display');
            }
        })
    } else {
        emotesData.map((emote) => {
            if(emote.id !== Id){
                document.querySelector(`.emote${emote.id}`).classList.remove('display');
            }
        })
    }
}
const playEmote = (emoteName) => {
    document.querySelector('.pause').classList.remove('hide');
    document.querySelector('.play').classList.add('hide');
    console.log(`${emoteName} is now playing.`);
}
const pauseEmote = () => {
    document.querySelector('.play').classList.remove('hide');
    document.querySelector('.pause').classList.add('hide');
    console.log(`${emoteName} is now paused.`);
}
const pushEmotes = (data) => {
    document.querySelector('.emotes').innerHTML = "";
    data.map((item) => {
        const {id, imageUrl, type} = item;
        document.querySelector('.emotes').innerHTML += `
        <div class='emote emote-image emote${id} ${type === 'dance' ? 'dance' : 'action'}' ondblclick="dblClickToAdd('.emote${id}')" onmouseover="displayNameOnHover(${id})" onmousedown="pressState(${id})">
            <img src=${imageUrl} alt="emote" draggable="false"/>
            <span class="pressState"></span>
        </div>
        `
    })
}
pushEmotes(emotesData)
let currentfilter = 'all';
categories.map((category) => {
    const {name, tab} = category
    tab.addEventListener('click', () => {
        if(name === "dance"){
            document.querySelectorAll('.action').forEach((elem) => {
                elem.classList.add('hide')
            })
            document.querySelectorAll('.dance').forEach((elem) => {
                elem.classList.remove('hide')
            })
        } else if (name ==="action"){
            document.querySelectorAll('.dance').forEach((elem) => {
                elem.classList.add('hide')
            })
            document.querySelectorAll('.action').forEach((elem) => {
                elem.classList.remove('hide')
            })
        } 
        else {
            document.querySelectorAll('.dance').forEach((elem) => {
                elem.classList.remove('hide')
            })
            document.querySelectorAll('.action').forEach((elem) => {
                elem.classList.remove('hide')
            })
        }
        tab.classList.add('active');
        categories.map((cat) => {
            if(cat.tab !== tab){
                cat.tab.classList.remove('active');
            }
        })
    })
})
const displayNameOnHover = (emoteId) => {
    let emoteHovered = emotesData.filter(emote => emote.id === emoteId);
    document.querySelector('.emotename').innerHTML = emoteHovered[0].name
}
// RADIAL MENU
const dropboxes = document.querySelectorAll('.line');
let emoteDropped = false;
const removeElement = (elem) => {
    let emoteClass = elem.classList[2];
    let originalElem = document.querySelector(`.${emoteClass}`);
    if (originalElem) {
        $(originalElem).draggable("enable");
        originalElem.classList.remove('selected');
    }
    document.querySelector('.radialemotename').innerHTML = "";
    elem.remove();
}
$(function(){
    $(".emote").draggable({
        cursor: "move", 
        revert:"invalid", 
        containment:"document", 
        helper: "clone",
        start: function(){
            $(this).addClass('dragged')
            console.log($('.dragged'))
            emoteDropped = false;
        },
        stop: function(){
            $(this).removeClass('dragged')
            $(".abs").removeClass('dropenter')
            $(".variant").removeClass('dropstate')
            $(".abs").each(function(index){
                $(this).attr('src', `images/variant${index+1}.svg` )
            })
            $('.radialemotename').text("")
        }
    })
})
$(".abs").each(function(index){
    var DI = $(this);
    DI.droppable({
        accept: ".emote",
        over: function(event, ui){
            DI.attr('src',`images/variant${index+1}state.svg`);
            DI.addClass('dropenter')
            DI.next().addClass('dropstate')
            let id  = $('.dragged').attr("class").split(/\s+/)
            let emoteDragged = emotesData.filter(emote => emote.id == Number(id[2].slice(5)));
            $('.radialemotename').text(emoteDragged[0].name)
        },
        out: function(event, ui){
            DI.attr('src',`images/variant${index+1}.svg`);
            DI.removeClass('dropenter');
            DI.next().removeClass('dropstate');
            $('.radialemotename').text("");
        },
        drop: function(event, ui){
            if(emoteDropped) {
                return;
            }
            var clonedElement = ui.helper.clone();
            let parentElement = $(this).parent()
            if(parentElement.children().length < 3){
                parentElement.append(clonedElement);
                $('.dragged').addClass('selected');
                $('.dragged').draggable("disable");
                selectedEmotes[index] = document.querySelector('.radialemotename').innerHTML
                console.log(selectedEmotes)
            } else {
                let replaced = $(this).siblings().last().attr("class").split(/\s+/)[2]
                $(`.${replaced}`).removeClass('selected')
                let originalElem = document.querySelector(`.${replaced}`);
                $(originalElem).draggable("enable")
                $(this).siblings().last().remove();
                parentElement.append(clonedElement);
                $('.dragged').addClass('selected');
                $('.dragged').draggable("disable");
            }
            $(clonedElement).on('contextmenu', function(e) {
                e.preventDefault();  
                removeElement(this); 
            });
            emoteDropped = true;
        }
    })
})
$(".line").on("click", function() {
    if($(this).children().length > 2) {
        let emoteElem = $(this).children().last();
        let emoteClass = emoteElem.attr("class").split(/\s+/)[2];
        let emoteClicked = emotesData.filter(emote => emote.id == Number(emoteClass.slice(5)));
        document.querySelector('#emotename').innerHTML = emoteClicked[0].name;
        document.querySelector('#emotetype').innerHTML = emoteClicked[0].type;
        document.querySelector('#emoteimg').src = emoteClicked[0].imageUrl;
        //playEmote(emoteClicked[0].name);
        console.log(emoteClicked[0].name);

        Events.Call("radialmenu::playEmote",emoteClicked[0].name,emoteClicked[0].id)

    }
});
$(".line").on("mouseover", function() {
    let absElement = $(this).find('.abs');
    if($(this).children().length > 2) {
        absElement.attr('src', `images/variant${$(this).index()+1}state.svg`);
        absElement.addClass('dropenter');
        absElement.next().addClass('dropstate');
        let emoteElem = $(this).children().last();
        let emoteClass = emoteElem.attr("class").split(/\s+/)[2];
        let emoteHovered = emotesData.filter(emote => emote.id == Number(emoteClass.slice(5)));
        $('.radialemotename').text(emoteHovered[0].name);
    }
}).on("mouseout", function() {
    let absElement = $(this).find('.abs');
    absElement.attr('src', `images/variant${$(this).index()+1}.svg`);
    absElement.removeClass('dropenter');
    absElement.next().removeClass('dropstate');
    $('.radialemotename').text("");
});
document.querySelector('.radial-menu').addEventListener("contextmenu", (event) => { event.preventDefault(); });


const dblClickToAdd = (emoteId) => {
    let elem = document.querySelector(emoteId)
    let copy = elem.cloneNode(true)
    if(!elem.classList.contains('selected')){
        let n = []
        let emptyVariants = []
        dropboxes.forEach((element) => { n.push(element) })
        n.map((i) => {
            if(i.childElementCount < 3){
                emptyVariants.push(i)
            } 
        })
        if(emptyVariants.length > 0){
            emptyVariants[0].appendChild(copy)
            console.log(emptyVariants[0].id)
            console.log(document.querySelector('#emotename').innerHTML)
            console.log(emoteId);

            Events.Call("radialmenu::addEmote",document.querySelector('.emotename').innerHTML,emptyVariants[0].id,emoteId)

            $(elem).addClass('selected') 
            let id  = $(elem).attr("class").split(/\s+/)[2]
            $(elem).draggable('disable')                                       
            selectedEmotes[emptyVariants[0].id] = document.querySelector('#emotename').innerHTML
            emptyVariants[0].lastElementChild.onmousedown = function(event){
                event.preventDefault()
                if(event.button == 2){ 
                    removeElement(emptyVariants[0].lastElementChild);
                }
            }  
        }
    }
}
// DISPLAY UI
const toggleDisplay = () =>{
    document.querySelector('.wrapper').classList.toggle('hidden')
    setTimeout(() => {
        document.querySelector('.container').classList.toggle('hideelem')
    }, 200);
}
document.addEventListener('keydown', evt => {
    if (evt.key === 'Home') {
        toggleDisplay();
    }
});
toggleDisplay();
