let audioPlayer = null;

if (!Vuex) {
    console.error("Vuex não está definido. Verifique se a biblioteca foi carregada corretamente.");
}

const store = Vuex.createStore({
    state() {
        return {
            notifications:   [],
            currentPosition: "left"
        };
    },
    mutations: {
        addNotification(state, notification) {
            state.notifications.push(notification);
        },
        clearNotifications(state) {
            state.notifications = [];
        },
        setPosition(state, position) {
            const valid = ["left", "right", "top", "bottom", "center"];
            state.currentPosition = valid.includes(position) ? position : "left";
        }
    },
    actions: {
        notification({ commit, state }, data) {
            let id = Date.now();

            if (state.notifications.length > 0) {
                if (state.notifications.some(n => n.message === data.data.message)) {
                    return;
                }
            }

            commit('setPosition', data.data.position || "left");

            commit('addNotification', {
                id:      id,
                message: data.data.message,
                key:     data.data.key,
                thema:   data.data.thema
            });

            clicksound("notification_sound.mp3");
        },
        clearNotifications({ commit }) {
            commit('clearNotifications');
        }
    }
});

const app = Vue.createApp({
    data() {
        return {};
    },
    mounted() {
        window.addEventListener("message", this.eventHandler);
    },
    beforeUnmount() {
        window.removeEventListener("message", this.eventHandler);
    },
    methods: {
        eventHandler(event) {
            if (!event.data) return;

            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("checkNUI");
                    break;

                case "SHOW_TEXTUI":
                    this.$store.dispatch("clearNotifications");
                    this.$store.dispatch("notification", event.data);
                    break;

                case "CLOSE_TEXTUI":
                    this.$store.dispatch("clearNotifications");
                    break;

                default:
                    break;
            }
        }
    },
    computed: {
        ...Vuex.mapState(['notifications', 'currentPosition']),

        // Classe Tailwind do container wrapper consoante a posição
        positionClass() {
            const map = {
                left:   "pos-left",
                right:  "pos-right",
                top:    "pos-top",
                bottom: "pos-bottom",
                center: "pos-center"
            };
            return map[this.currentPosition] || "pos-left";
        },

        // Nome da transição Vue consoante a posição
        animName() {
            return `fade-${this.currentPosition}`;
        }
    }
});

app.use(store);
app.mount("#app");

var resourceName = "codem-textui";
if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: { "Content-Type": "application/json" },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        console.error("Erro ao enviar mensagem NUI:", error);
    }
};

function clicksound(val) {
    let audioPath = `./sound/${val}`;
    audioPlayer = new Howl({ src: [audioPath] });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}