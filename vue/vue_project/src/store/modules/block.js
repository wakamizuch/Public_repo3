import api from "@/api";
export default {
  namespaced: true,
  state: {
    blockedList: [],
  },
  getters: {
    blockedList: (state) => state.blockedList,
  },
  actions: {
    //ブロックされている人のリスト保持
    loadBlockedList({ commit }, { userId }) {
      api.get(`get_blocked_list/${userId}`).then(function ({ data }) {
        console.log("次にブロックのセットです" + data);
        commit("setBlockedList", { data });
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
              dispatch(`loadBlockedList`, { userId: userId });
            });
        });
    },
  },

  mutations: {
    setBlockedList(state, { data }) {
      console.log("setBlockedList");
      console.log(data.blockedList);
      const blockedList = [];
      //連想配列だからkey
      for (var key in data.blockedList) {
        blockedList.push(data.blockedList[key].blocked_id);
      }
      console.log(blockedList);
      state.blockedList = blockedList;
    },
  },
};
