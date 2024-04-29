class BlockRelationController < ApplicationController
  def index
    pp index_params[:blocker_id]
    puts "ブロックの、index始めます"
    block_relation = BlockRelationship.where(
      blocker_id: index_params[:blocker_id],
      block_now: true,
    )
    render_success blockedList:block_relation
  end

  # すでにあるなら　!現在　に変更
  # ないなら、　trueにセットする
  def create
    puts block_relation_params
    block_relation = BlockRelationship.find_by(
      blocker_id: block_relation_params[:blocker_id],
      blocked_id: block_relation_params[:blocked_id],
    )
    #もうすでにあるなら、アップデート
    if block_relation!= nil
      puts "成功しました"
      if block_relation.update(block_now: !(block_relation.block_now))
        pp block_relation
        render_success blockedList:block_relation
      else
        render_error
      end
    else
      #ないなら新たに作成
      puts "新たに作成します"
      block_relation = BlockRelationship.new(
        blocker_id: block_relation_params[:blocker_id],
        blocked_id: block_relation_params[:blocked_id],
        block_now: true,
      )
      if block_relation.save
        pp "うまくいけました"
        render_success blockedList:block_relation
      else
        render_error
      end
    end

  end
  
  private
  def block_relation_params
    params.require(:block_relation).permit(:blocker_id, :blocked_id )
  end
  def index_params
    params.permit(:blocker_id)
  end

end
  