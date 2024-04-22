import api from "@/api";
export default {
  namespaced: true,
  state: {
    fightTaskList: [],
  },
  getters: {
    fightTaskList: (state) => state.fightTaskList,
  },
  actions: {
    //fight関連
    loadFightTaskList({ commit }, { userId }) {
      console.log(JSON.stringify(userId));
      //const user_Id = { userId };
      const res = api
        .get(`get_fight_task_list/${userId}`)
        .then(function ({ data }) {
          console.log("次にfightのセットです" + data);
          commit("setFightTaskList", { data });
        });
    },
    //最終的には、変更後にロードを呼び出すことになる
    fight({ dispatch }, { userId, taskId }) {
      const res = api
        .post("fight", {
          fight: { user_id: userId, task_id: taskId },
        })
        .then(function ({ data }) {
          console.log(data.fight);
          api
            .post("updateFightNum", {
              fight: data.fight,
            })
            .then(function ({ data }) {
              console.log(data.task);
              dispatch(`loadFightTaskList`, { userId: userId });
            });
        });
    },
  },

  mutations: {
    setFightTaskList(state, { data }) {
      console.log("setFightTaskList");
      console.log(data.fight);
      const fight = [];
      //連想配列だからkey
      for (var key in data.fight) {
        fight.push(data.fight[key].task_id);
      }
      console.log(fight);
      state.fightTaskList = fight;
    },
  },
};
