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
        console.log("次にブロックのセットです" + data.blockedList);
        commit("setBlockedList", { data });
      });
    },
    //最終的には、変更後にロードを呼び出すことになる
    block({ dispatch }, { blockerId, blockedId }) {
      const res = api
        .post("block", {
          block_relation: { blocker_id: blockerId, blocked_id: blockedId },
        })
        .then(function ({ data }) {
          console.log(data.blockedList);
          dispatch("loadBlockedList", {
            userId: blockerId,
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
        console.log(key+":  ", data.blockedList[key].blocked_id);
        blockedList.push(data.blockedList[key].blocked_id);
      }
      console.log("結果はこんな感じです"+blockedList);
      state.blockedList = blockedList;
    },
  },
};
