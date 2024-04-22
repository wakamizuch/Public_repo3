<template>
  <div class="task-card">
    <div class="task-card-user-name">
      投稿者:{{ taskCard.user_name }} タスクID:{{ taskCard.id }}
    </div>
    <div class="task-card-text">{{ taskCard.text }}</div>
    <div
      class="task-card-checkbox"
      v-if="taskCard.user_id == this.$store.getters.userId"
    >
      <div class="box-class">
        <label
          >完了したらチェック!
          <input
            type="checkbox"
            id="checkbox-name"
            v-model="taskCard.is_task_finished"
            @click="change_flag"
          />
        </label>
      </div>
      <!--<pre>{{ taskCard.is_task_finished }}</pre>-->
    </div>
    <!--<p>{{ this.$store.getters["fight/fightTaskList"] }}</p> -->

    <!--自分以外の人はフォローできる-->
    <div class="follow" v-if="taskCard.user_id != this.$store.getters.userId">
      <!--<div>{{ taskCard.fight_num }},{{ this.$store.getters.followedList }}</div> -->
      <!--<p>
        ファイトされてるタスクid:{{
          this.$store.getters["fight/fightTaskList"].includes(taskCard.id)
        }}
      </p> -->
      <button v-on:click="change_fight(fightFlag)" class="box-class">
        {{
          this.$store.getters["fight/fightTaskList"].includes(taskCard.id)
            ? "いいね中です"
            : "いいねしますか?"
        }}
      </button>
      <button v-on:click="change_relation" class="box-class">
        {{
          this.$store.getters.followedList.includes(taskCard.user_id)
            ? "フォロー中です"
            : "フォローする"
        }}
      </button>
      <router-link
        class="box-class"
        :to="`/other_page/${taskCard.user_id}}`"
        v-if="this.$store.getters.followedList.includes(taskCard.user_id)"
      >
        全投稿をチェック</router-link
      >
    </div>
    <div>いいねの数:{{ taskCard.fight_num }}</div>
  </div>
</template>

<script>
import { ref } from "vue";
export default {
  name: "TaskCard",
  components: {},
  data() {
    return {
      followedList: ref(this.$store.getters.followedList),
      fightTaskList: ref(this.$store.getters["fight/fightTaskList"]),
      //fightTaskList:fightTaskList,
      fightFlag: this.$store.getters["fight/fightTaskList"].includes(
        this.taskCard.id
      ),
    };
  },
  props: {
    taskCard: {
      type: Object,
      default: () => {},
    },
  },
  create() {
    this.init();
    //this.loadFollowedList();
    //this.fightTaskList = this.$store.getters["fight/fightTaskList"],
  },
  computed: {
    increment: function () {
      this.taskCard.fight_num += 1;
    },
    decrement: function () {
      this.taskCard.fight_num -= 1;
    },
  },
  methods: {
    //init() {
    //  this.followedList = this.$store.getters.followedList,
    //  this.fightTaskList = this.$store.getters["fight/fightTaskList"];
    //},
    // 自分のタスクに関して
    async change_flag() {
      console.log(this.taskCard.id + "番のタスクが変化しました");
      const task_id = this.taskCard.id;
      await this.$store.dispatch("updateTaskFlag", { task_id });
      //this.taskCard = this.$store.getters.task
    },
    //　他の人のタスクに関して
    async change_fight(fightFlag) {
      console.log(this.taskCard.id + "番のファイトが変化しました");
      console.log("fightFlag:" + fightFlag);
      if (fightFlag == false) {
        this.increment;
      } else {
        this.decrement;
      }
      const taskId = this.taskCard.id;
      const userId = this.$store.getters.userId;
      await this.$store.dispatch("fight/fight", { userId, taskId });

      this.fightTaskList = this.$store.getters["fight/fightTaskList"];
      this.fightFlag = !this.fightFlag;
    },

    //async loadFollowedList() {
    //  console.log("ロードされました(FollowedList)");
    //  const userId = this.$store.getters.userId;
    //  await this.$store.dispatch("loadFollowedList", { userId });
    //},
    async change_relation() {
      console.log(
        this.$store.getters.userId +
          "と" +
          this.taskCard.id +
          "の関係が変化しました"
      );
      const followed_id = this.taskCard.user_id;
      const follower_id = this.$store.getters.userId;
      //api
      //  .post("follow", {
      //    relation: { follower_id: follower_id, followed_id: followed_id },
      //  })
      //  .then(function(){
      //    this.$store.dispatch("setFollowedList");
      //  });
      await this.$store.dispatch("follow", { follower_id, followed_id });
      //this.followedList = this.$store.getters.followedList
      //.then(function () {
      //  dispatch("setFollowedList");
      //});
    },
  },
};
</script>

<style lang="scss" scoped>
.task-card {
  overflow: auto;
  //margin :0 auto;
  margin: 5px;
  position: relative;
  width: 600px;
  height: min-content;
  min-height: 100px;
  background-color: rgb(240, 240, 232);
  padding: 12px;
  box-sizing: border-box;
  border: 2px solid #324c2c;
  border-radius: 8px;
  box-shadow: 5px 5px 5px #0f4703;
  cursor: pointer;
  &:hover {
    background-color: rgb(178, 238, 220);
    right: 4px;
    bottom: 2px;
  }

  &-text {
    font-size: 20px;
    font-weight: bold;
    user-select: none;
    padding: 15px;
  }
  &-user-name {
    display: inline-block;
    padding: 2px;
    font-size: 17px;

    user-select: none;
    text-decoration-line: underline;
    //border: 2px solid #3f443e;
    //border-radius: 4px;
  }
  .box-class {
    margin-bottom: 5px;
    margin-right: 5px;
    font-size: 14px;
    display: inline-block;
    padding: 5px;
    right: 4px;
    bottom: 4px;
    border: 2px solid black;
    border-radius: 5px;
    background-color: beige;
    text-decoration: none;
  }
  .box-class:hover {
    background-color: rgb(233, 233, 94);
    right: 4px;
    bottom: 4px;
  }
  &-checkbox:hover {
    right: 4px;
    bottom: 4px;
  }
  input[type="checkbox"] {
    position: relative;
    width: 16px;
    height: 16px;
    border: 1px solid #000;
    vertical-align: -5px;
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
  }

  input[type="checkbox"]:checked:before {
    position: absolute;
    top: 1px;
    left: 4px;
    transform: rotate(50deg);
    width: 4px;
    height: 8px;
    border-right: 2px solid #000;
    border-bottom: 2px solid #000;
    content: "";
  }
}
</style>
