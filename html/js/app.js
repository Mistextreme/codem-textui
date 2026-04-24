let audioPlayer = null;

// Verificação da disponibilidade do Vuex
if (!Vuex) {
    console.error("Vuex não está definido. Verifique se a biblioteca foi carregada corretamente.");
}

// Criação do store usando a sintaxe correta do Vuex 4
const store = Vuex.createStore({
    state() {
        return {
            notifications: []
        };
    },
    mutations: {
        addNotification(state, notification) {
            state.notifications.push(notification);
        },
        clearNotifications(state) {
            state.notifications = [];
        }
    },
    actions: {
        notification({ commit, state }, data) {
            let id = Date.now();
            
            // Verifica se já existe uma notificação idêntica
            if (state.notifications.length > 0) {
                if (state.notifications.some(notification => notification.message === data.data.message)) {
                    return;
                }
            }

            // Adiciona a notificação
            commit('addNotification', {
                id: id,
                message: data.data.message,
                key: data.data.key,
                thema: data.data.thema
            });
            
            // Toca o som de notificação
            clicksound("notification_sound.mp3");
        },
        clearNotifications({ commit }) {
            commit('clearNotifications');
        }
    }
});

// Cria a aplicação Vue
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
            // Garante que event.data existe
            if (!event.data) return;
            
            switch (event.data.action) {
                case "CHECK_NUI":
                    postNUI("checkNUI");
                    break;
                    
                case "SHOW_TEXTUI":
                    // Limpa notificações anteriores antes de adicionar novas
                    this.$store.dispatch("clearNotifications");
                    
                    // Adiciona a nova notificação
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
        ...Vuex.mapState(['notifications'])
    }
});

// Adiciona o store à aplicação e monta
app.use(store);
app.mount("#app");

// Obtém o nome do recurso
var resourceName = "codem-textui";
if (window.GetParentResourceName) {
    resourceName = window.GetParentResourceName();
}

// Função para postar mensagens NUI
window.postNUI = async (name, data) => {
    try {
        const response = await fetch(`https://${resourceName}/${name}`, {
            method: "POST",
            mode: "cors",
            cache: "no-cache",
            credentials: "same-origin",
            headers: {
                "Content-Type": "application/json"
            },
            redirect: "follow",
            referrerPolicy: "no-referrer",
            body: JSON.stringify(data)
        });
        return !response.ok ? null : response.json();
    } catch (error) {
        console.error("Erro ao enviar mensagem NUI:", error);
    }
};

// Função para tocar sons
function clicksound(val) {
    let audioPath = `./sound/${val}`;
    audioPlayer = new Howl({
        src: [audioPath]
    });
    audioPlayer.volume(0.4);
    audioPlayer.play();
}
