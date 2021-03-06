require "compiler/crystal/syntax"

class LibGenerator::RemoveTransformer < Crystal::Transformer
  def initialize(@nodes_to_remove : Array(Crystal::ASTNode))
  end

  # def transform(node : Crystal::ASTNode)
  def transform(node : (Crystal::FunDef | Crystal::TypeDef | Crystal::CStructOrUnionDef | Crystal::EnumDef | Crystal::Alias | Crystal::ExternalVar | Crystal::Assign))
    if @nodes_to_remove.includes?(node)
      Crystal::Nop.new
    else
      super
    end
  end

  def after_transform(node : Crystal::Expressions)
    node.expressions.select! { |n| !n.is_a?(Crystal::Nop) }
  end
end
