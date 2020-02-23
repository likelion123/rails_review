ActiveAdmin.register Post do
  # 게시물 관리라는 상위 메뉴로 그루핑
  menu parent: "게시물 관리"

  scope -> { '전체' }, :all, default: true
  scope -> { '초안' }, :draft
  scope -> { '발행' }, :publish
  scope -> { '취소' }, :canceled

  # 작성자, 글 제목, 작성일 로 필터링, 검색할 수 있는 filter
  filter :user
  filter :title
  filter :created_at

  # index 페이지를 표시하는 부분
  index do
    selectable_column
    id_column
    column :title
    column :content
    column :status
    actions do |resource|
      a "발행", href: publish_admin_post_path(resource), method: :put, class: "member_link" if resource.draft?
    end
  end

  show do
    attributes_table do
      row :id
      row :title
      row :content
    end
  end

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :status
    end
    # 저장/취소 버튼
    f.actions
  end

  member_action :publish, method: :put do
    # resource 는 @post = Post.find[:id]
    resource.publish!

    # resource_path는 admin/posts 주소
    redirect_to resource_path, notice: "발행되었습니다."
  end

  action_item :publish, only: :show do
    link_to "발행", publish_admin_post_path(resource), method: :put if resource.draft?
  end
end
