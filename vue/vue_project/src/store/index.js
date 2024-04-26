import Vue from "vue";
import Vuex from "vuex";
import createPersistedState from "vuex-persistedstate";
import api from "@/api";
import fight from "@/store/modules/fight.js";
import block from "@/store/modules/block.js";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    sampleItems: [],
    isLoggedIn: false,
    userId: null,
    userName: null,
    followedList: [],
    taskCards: [],
  },
  getters: {
    sampleItems: (state) => state.sampleItems,
    userId: (state) => state.userId,
    isLoggedIn: (state) => state.isLoggedIn,
    followedList: (state) => state.followedList,
    taskCards: (state) => state.taskCards,
  },
  actions: {
    // 4.loadSampleItems が行われる
    async loadSampleItems({ commit }) {
      // 5.resは,apiのgetの'sample_items'から
      const res = await api.get("sample_items");
      // 8.sampleItemsにsample_itemsが入ります
      const sampleItems = res.data.sample_items;
      window.alert(sampleItems);
      commit("setSampleItems", { sampleItems });
      return sampleItems;
    },

    //a3.resは,apiのpostの'sample_items'からもらう
    async addSampleItem({ commit }, { text }) {
      const res = await api.post("sample_items", {
        sample_item: { text: text },
      });
      const sampleItem = res.data.sample_item;
      //a6.mutationsの'addSampleItem'を実行します
      commit("addSampleItem", { sampleItem });
      return sampleItem;
    },
    async addUserData({ commit }, { inputName, inputEmail, inputPassword }) {
      const res = await api.post("addUserData", {
        user: { name: inputName, email: inputEmail, password: inputPassword },
      });
      //console.log(res.data);
      const link_to = res.data.link_to;
      alert("データ:" + link_to.name);
      if (link_to.name == "SignUp") {
        alert("氏名、あるはメールアドレスはすでに使われています");
      }
      ////console.log(res)
      const sampleItem = res.data.sample_item;
      //a6.mutationsの'addSampleItem'を実行します
      commit("addSampleItem", { sampleItem });
      return link_to;
    },

    async login({ commit }, { inputEmail, inputPassword }) {
      const res = await api.post("login", {
        user: { email: inputEmail, password: inputPassword },
      });
      //console.log(res.data);
      const userId = res.data.userId;
      if (userId >= 0) {
        commit("setIsLoggedIn", { userId });
      } else {
        alert("パスワードが異なります");
      }
      return userId;
    },
    //task関連
    async loadMyTaskCards({ commit, getters }, { user_id }) {
      //console.log("あ" + getters.userId);
      //console.log(JSON.stringify({ user: { user_id: user_id } }));
      const res = await api.get(`load_my_task_cards/${user_id}`);
      return res.data.tasks;
    },
    async loadTaskCards({ commit, getters }) {
      const user_id =getters.userId
      const res = await api.get(`load_task_cards/${user_id}`);
      //const tasks = res.data.tasks;
      //console.log("res.data: ");
      commit("setTaskCards", { tasks: res.data.tasks });
      return getters.taskCards;
    },

    async loadFightCards({ getters }, { fightTaskList }) {
      const user_id = getters.userId;
      const res = await api.get(`load_task_cards/${user_id}`);
      //console.log(fightTaskList);
      //console.log("どうかな: " + fightTaskList.includes(res.data.tasks[1].id));
      let tasks = [];
      tasks = res.data.tasks.filter(function (task) {
        return fightTaskList.includes(task.id);
      });
      //console.log("good" + tasks);
      return tasks;
    },
    createTask({ commit }, { userId, text }) {
      const res = api
        .post("create_task", {
          task: { user_id: userId, text: text },
        })
        .then(function ({ data }) {
          //console.log(data.task);
          commit("addTaskCards", { task: data.task });
        });
    },

    async updateTaskFlag({ commit }, { task_id }) {
      //console.log(task_id);
      const res = await api.post("update_task_flag", {
        task: { task_id: task_id },
      });
    },

    //relation関連
    loadFollowedList({ commit }, { userId }) {
      //console.log(JSON.stringify(userId));
      //const user_Id = { userId };
      const res = api
        .get(`get_followed_list/${userId}`)
        .then(function ({ data }) {
          //console.log("今いい感じです");
          //console.log(data);
          commit("setFollowedList", { data });
        });
    },
    follow({ dispatch }, { follower_id, followed_id }) {
      //console.log("idは: " + followed_id);
      const res = api
        .post("follow", {
          relation: { follower_id: follower_id, followed_id: followed_id },
        })
        .then(function () {
          //console.log("次にロードします" + follower_id);
          dispatch(`loadFollowedList`, { userId: follower_id });
        });
      ////console.log(JSON.stringify(res.data.relation));
      //return res.data.relation;
    },
  },
  mutations: {
    setSampleItems(state, { sampleItems }) {
      state.sampleItems = sampleItems;
    },
    //a7 state.sampleItemsにsampleItemが追加されました
    addSampleItem(state, { sampleItem }) {
      state.sampleItems.push(sampleItem);
    },

    setIsLoggedIn(state, { userId }) {
      state.isLoggedIn = true;
      alert(".js" + state.userId);
      state.userId = userId;
      alert(state.userId);
      //console.log(state.userId);
    },
    setFollowedList(state, { data }) {
      //console.log("setFollowedList");
      const relation = [];
      for (var key in data.relation) {
        relation.push(data.relation[key].followed_id);
      }
      //console.log(relation);
      state.followedList = relation;
    },
    setTaskCards(state, { tasks: tasks }) {
      state.taskCards = tasks;
    },
    addTaskCards(state, { task }) {
      state.taskCards.unshift(task);
    },
  },
  modules: { fight ,block},
  plugins: [
    createPersistedState({
      // ストレージのキーを指定。デフォルトではvuex
      key: "userId",
      // 管理対象のステートを指定。pathsを書かない時は`modules`に書いたモジュールに含まれるステート全て。`[]`の時はどれも保存されない
      paths: [
        "sampleItems",
        "isLoggedIn",
        "userId",
        "followedList",
        "taskCards",
        "fight.fightTaskList",
        "block.blockedList"
      ],
      // ストレージの種類を指定する。デフォルトではローカルストレージ
      storage: window.sessionStorage,
    }),
  ],
});
