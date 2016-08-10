###什么是UIStackview
在iOS9中苹果在UIKit框架中引入了一个新的视图类UIStackView。UIStackView 类提供了一个高效的接口用于平铺一行或一列的视图组合。Stack视图管理着所有在它的 arrangedSubviews 属性中的视图的布局。这些视图根据它们在 arrangedSubviews 数组中的顺序沿着 Stack 视图的轴向排列。
简而言之，即UIStackView，就是一个ContainerView，可以沿横向或纵向按照一定的规则布局内部的子View。

####arrangedSubviews方法介绍

UIStackView使用arrangedSubviews数组来管理子视图。

需要注意的是这个数组是一个readonly的属性，我们需要调用方法对arrangedSubviews数组进行操作。

	初始化数组:
	- (instancetype)initWithArrangedSubviews:(NSArray *)views;
	添加子视图: 
	- (void)addArrangedSubview:(UIView *)view;
	移除子视图:
	- (void)removeArrangedSubview:(UIView *)view;
	根据下标插入视图:
	- (void)insertArrangedSubview:(UIView *)viewatIndex:(NSUInteger)stackIndex;
	注意： addArrangedSubview 和 insertArrangedSubview， 会把子控件加到arrangedSubviews数组的同时添加到StackView上，但是removeArrangedSubview， 只会把子控件从arrangedSubviews数组中移除，不会从subviews中移除，如果需要可调用removeFromSuperview

####属性介绍
1， axis：子控件的布局方向，水平或垂直， 这个不用过多解释了

2， spacing：子控件之间的最小间距，之所以说是最小间距，因为stackView会根据一定的规则对内部空间布局，有的时候不能满足所有要求，比如stackView 本身宽度100，内部两个控件，宽度都为50，50+50+10就超过了本身宽度， 这时会压缩其中一个子控件的宽度来满足最小间距。

3， distribution：子控件依据何种规则布局， 这个比较抽象， 看示例理解的快一点，以下示例均使用UILabel演示， 原因见插播

插播：先了解一下什么是Intrinsic Content Size（固有尺寸），
因为UIStackView对子控件的布局是建立在Autolayout基础之上的，
会涉及到Intrinsic Content Size
想一下当为一个Label创建约束时，是不是经常只指定上边距和左边距，
相信原因大家都知道，label内部的文字自会撑开宽高， 
这个根据内容自己撑开的宽高就是Intrinsic Content Size。
怎样给一个UIView设置Intrinsic Content Size 或者改变label的Intrinsic Content Size？
继承然后重写

	- (CGSize)intrinsicContentSize
	{
    	CGSize originalSize = [super intrinsicContentSize];
    	CGSize size = CGSizeMake(originalSize.width+20,originalSize.height+20)；
    	return size;
	}
UIStackViewDistribution 是个枚举值， 各个值如下， 配有示例图， 看不懂就只能自求多福了：

	UIStackViewDistributionFill ：它就是将 arrangedSubviews 填充满整个 StackView ，如果设置了spacing，那么这些 arrangedSubviews 之间的间距就是spacing。如果减去所有的spacing，所有的 arrangedSubview 的固有尺寸( intrinsicContentSize )不能填满或者超出 StackView 的尺寸，那就会按照 Hugging 或者 CompressionResistance 的优先级来拉伸或压缩一些 arrangedSubview 。如果出现优先级相同的情况，就按排列顺序来拉伸或压缩。

	UIStackViewDistributionFillEqually ：这种就是 StackView 的尺寸减去所有的spacing之后均分给 arrangedSubviews ，每个 arrangedSubview 的尺寸是相同的。

	UIStackViewDistributionFillProportionally ：这种跟FillEqually差不多，只不过这个不是讲尺寸均分给 arrangedSubviews ，而是根据 arrangedSubviews 的 intrinsicContentSize 按比例分配。

	UIStackViewDistributionEqualSpacing ：这种是使 arrangedSubview 之间的spacing相等，但是这个spacing是有可能大于 StackView 所设置的spacing，但是绝对不会小于。这个类型的布局可以这样理解，先按所有的 arrangedSubview 的 intrinsicContentSize 布局，然后余下的空间均分为spacing，如果大约 StackView 设置的spacing那这样就OK了，如果小于就按照 StackView 设置的spacing，然后按照 CompressionResistance 的优先级来压缩一个 arrangedSubview 。

	UIStackViewDistributionEqualCentering ：这种是使 arrangedSubview 的中心点之间的距离相等，这样没两个 arrangedSubview 之间的spacing就有可能不是相等的，但是这个spacing仍然是大于等于 StackView 设置的spacing的，不会是小于。这个类型布局仍然是如果 StackView 有多余的空间会均分给 arrangedSubviews 之间的spacing，如果空间不够那就按照 CompressionResistance 的优先级压缩 arrangedSubview 。

4，alignment 子控件对其方式，类似UIlabel的textAlignment， 可以做一个类比， UILabel对应UIStackView， label的内容对应StackView的子控件。

UIStackViewDistribution 是个枚举值， 各个值如下：

	UIStackViewAlignmentFill , 默认方式， 如果子控件水平布局, 则指子控件的垂直方向填充满stackView. 反之亦然

	UIStackViewAlignmentLeading , 如果子控件竖直布局, 则指子控件左边对齐stackView左边. 反之亦然, 即 UIStackViewAlignmentTop = UIStackViewAlignmentLeading。

	UIStackViewAlignmentTop = UIStackViewAlignmentLeading,

	UIStackViewAlignmentFirstBaseline , 根据上方基线布局所有子视图的 y 值(适用于 Horizontal 模式)， 这种模式没搞懂， 有知道怎么回事的求教了

	UIStackViewAlignmentLastBaseline , 根据下方基线布局所有子视图的 y 值(适用于 Horizontal 模式)

	UIStackViewAlignmentCenter , 中心对齐

	UIStackViewAlignmentTrailing , 如果子控件竖直布局, 则指子控件左边对齐stackView右边. 反之亦然, 即UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing

	UIStackViewAlignmentBottom = UIStackViewAlignmentTrailing,
