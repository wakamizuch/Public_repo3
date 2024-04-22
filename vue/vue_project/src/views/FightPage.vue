<template>
  <div class="fight-page">
    <div>
      <LinkList />
    </div>
    <!-- <p>{{ this.$store.getters["fight/fightTaskList"] }}</p> -->

    <div class="header">
      <div class="title">
        <p>いいねしたタスク一覧</p>
      </div>
    </div>
    <div class="show-all">
      <TaskCard
        v-for="(taskCard, index) in taskCards"
        :key="index"
        :taskCard="taskCard"
      />
    </div>
  </div>
</template>
<script>
import TaskCard from "@/components/TaskCard";
import LinkList from "@/components/LinkList";

export default {
  name: "FightPage",
  components: {
    TaskCard,
    LinkList,
  },
  data() {
    return {
      taskCards: [],
      inputText: "",
    };
  },
  created() {
    this.loadFightTasks();
  },
  methods: {
    async loadFightTasks() {
      console.log("ロードされました(LoadFightList)");
      this.taskCards = await this.$store.dispatch("loadFightCards", {
        fightTaskList: this.$store.getters["fight/fightTaskList"],
      });
      console.log("どうかな" + this.taskCards);
    },
  },
};
</script>

<style lang="scss" scoped>
//# { visibility: hidden; }
.fight-page {
  background-color: rgb(193, 238, 235);
  background-size: cover;
  min-height: 1200px;
  padding: 5% 0px;
  .title {
    font-size: 36px;
    font-weight: bold;
  }
  .header {
    padding-top: 100px;
    //margin: 10px 100px;
    width: 80%;
    //text-align: center;
    margin: 10px auto;
  }
  .show-all {
    width: 80%;
    //text-align: center;
    margin: 10px auto;
  }
  //#.inputForm {
  //  visibility: hidden;
  //}
  .add-button {
    height: 40px;
    width: 64px;
    border-radius: 4px;
    line-height: 40px;
    text-align: center;
    background-color: #5af;
    color: white;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
    user-select: none;

    &:hover {
      background-color: #7cf;
    }
  }
  textarea {
    width: 200px; /* 横幅 */
    height: 100px; /* 高さ */
  }

  .inputForm {
    margin: 20px;
  }
}
</style>
