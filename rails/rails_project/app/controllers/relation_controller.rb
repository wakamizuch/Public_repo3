class RelationController < ApplicationController
  def index
    pp index_params[:follower]
    puts "index始めます"
    relation = Relationship.where(
      follower_id: index_params[:follower],
      follow_now: true,
    )
    render_success relation:relation
  end

  def create
    puts relation_params
    relation = Relationship.find_by(
      follower_id: relation_params[:follower_id],
      followed_id: relation_params[:followed_id],
    )
    #もうすでにあるなら、アップデート
    if relation!= nil
      puts "成功しました"
      if relation.update(follow_now: !(relation.follow_now))
        render_success relation:relation
      else
        render_error
      end
    else
      #ないなら新たに作成
      puts "新たに作成します"
      relation = Relationship.new(
        follower_id: relation_params[:follower_id],
        followed_id: relation_params[:followed_id],
        follow_now: true,
      )
      if relation.save
        pp "うまくいけました"
        render_success relation:relation
      else
        render_error
      end
    end

  end
  
  private
  def relation_params
    params.require(:relation).permit(:follower_id, :followed_id )
  end
  def index_params
    params.permit(:follower )
  end

end
  