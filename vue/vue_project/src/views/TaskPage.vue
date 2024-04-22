<template>
  <div class="task-page">
    <div class="tab">
      <LinkList />
    </div>
    <!-- -->
    <div class="header">
      <div class="title">
        <p>タスクページ</p>
        <!--<p>ようこそ {{ this.$store.getters.userId }} 番さん</p> -->
      </div>
      <!-- <p>{{ this.$store.getters.taskCards }}</p> -->
      <div class="input-form">
        <textarea v-model="inputText" placeholder="タスク内容を書きましょう">
        </textarea>
        <div>
          <input
            class="box-class"
            type="button"
            value="作成"
            @click="createTask"
          />
        </div>
      </div>
    </div>
    <div class="show-all">
      <TaskCard
        v-for="(taskCard, index) in taskCards"
        :key="index"
        :taskCard="taskCard"
      />
    </div>
    <p>{{ fightTaskList }}</p>
    <p>{{ this.$store.getters["fight/fightTaskList"] }}</p>
    <p>↑fightしているtaskId</p>
    <p>{{ this.$store.getters.followedList }}</p>
    <p>{{ followedList }}</p>
    <p>↑フォローしているuserId</p>
  </div>
</template>
<script>
import TaskCard from "@/components/TaskCard";
import LinkList from "@/components/LinkList";
import { reactive } from "vue";
import { ref } from "vue";
export default {
  name: "TaskPage",
  components: {
    TaskCard,
    LinkList,
  },
  data() {
    return {
      //fightTaskList: ref(this.$store.getters["fight/fightTaskList"]),
      taskCards: this.$store.getters.taskCards,
      inputText: "",
      followedList: ref(this.$store.getters.followedList),
    };
  },
  computed: {
    fightTaskList() {
      return this.$store.getters["fight/fightTaskList"];
    },
  },
  created() {
    this.loadTaskCards();
    this.loadFollowedList();
    this.loadFightTaskList();
  },
  methods: {
    async loadFollowedList() {
      console.log("ロードされました(FollowedList)");
      const userId = this.$store.getters.userId;
      await this.$store.dispatch("loadFollowedList", { userId: userId });
      this.followedList = this.$store.getters.followedList;
    },
    async loadFightTaskList() {
      console.log("ロードされました(FightTaskList)");
      const userId = this.$store.getters.userId;
      await this.$store.dispatch("fight/loadFightTaskList", { userId: userId });
      this.fightTaskList = this.$store.getters["fight/fightTaskList"];
    },
    async loadTaskCards() {
      console.log("ロードされました(LoadTaskList)");
      this.taskCards = await this.$store.dispatch("loadTaskCards", {});
    },
    async createTask() {
      if (!this.inputText) {
        return alert("入力がありません");
      }
      alert("タスクを作成しました");
      await this.$store.dispatch("createTask", {
        userId: this.$store.getters.userId,
        text: this.inputText,
      });
      //this.taskCards = this.$store.getters.taskCards;
      this.inputText = "";
    },
  },
};
</script>

<style lang="scss" scoped>
//# { visibility: hidden; }
//body{background-color: rgb(61, 168, 160);}

.task-page {
  //padding-top: 200px;
  background-color: rgb(193, 238, 235);
  min-height: 1200px;
  padding: 5% 0px;
  .top {
    background-color: rgb(73, 234, 223);
    width: 100%;
  }
  .header {
    padding-top: 100px;
    //margin: 10px 100px;
    width: 80%;
    //text-align: center;
    margin: 10px auto;
  }
  .title {
    font-size: 36px;
    font-weight: bold;
  }
  .show-all {
    width: 80%;
    //text-align: center;
    margin: 10px auto;
  }
  //#.inputForm {
  //  visibility: hidden;
  //}
  .input-form textarea {
    font-size: 20px;
    height: 100px;
    width: 400px;
    border: 2px solid #324c2c;
    border-radius: 8px;
    //box-shadow: 5px 5px 5px #0f4703;
  }
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

  .inputForm {
    display: float;
    margin: 20px;
  }
  .box-class {
    margin-bottom: 5px;
    font-size: 20px;
    display: inline-block;
    padding: 10px 30px;
    right: 4px;
    bottom: 4px;
    border: 2px solid black;
    border-radius: 5px;
    background-color: beige;
    text-decoration: none;
  }
  .box-class:hover {
    background-color: rgb(233, 233, 94);
    right: 40px;
    bottom: 4px;
  }
}
</style>
